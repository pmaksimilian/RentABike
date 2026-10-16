table 50109 "Rental Line"
{
    Caption = 'Rental Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Rental No."; Code[20])
        {
            Caption = 'Rental No.';
            DataClassification = CustomerContent;
            TableRelation = "Rental Header"."No.";
            NotBlank = true;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            MinValue = 1;
        }

        field(3; "Bicycle No."; Code[20])
        {
            Caption = 'Bicycle No.';
            DataClassification = CustomerContent;
            NotBlank = true;

            TableRelation = Bicycle."No." where(Status = const(Available));

            trigger OnValidate()
            var
                BicycleRec: Record Bicycle;
                RentalHeader: Record "Rental Header";
                RentalType: Record "Rental Type";
                RentalPriceList: Record "Rental Price List";
            begin
                if "Bicycle No." = '' then
                    exit;

                if not RentalHeader.Get("Rental No.") then
                    Error('Za vrstico izposoje ne obstaja glava izposoje.');

                if not BicycleRec.Get("Bicycle No.") then
                    Error('Izbranega kolesa ni mogoče najti.');

                if BicycleRec."Rental Type Code" = '' then
                    Error('Izbrano kolo nima določenega tipa kolesa.');

                if not RentalType.Get(BicycleRec."Rental Type Code") then
                    Error('Tip kolesa %1 ne obstaja.', BicycleRec."Rental Type Code");

                Description := BicycleRec.Description;

                RentalPriceList.SetRange(
                    "Rental Type Code",
                    BicycleRec."Rental Type Code");
                RentalPriceList.SetFilter(
                    "Starting Date",
                    '<=%1',
                    RentalHeader."Rental Date");
                RentalPriceList.SetFilter(
                    "Ending Date",
                    '>=%1',
                    RentalHeader."Rental Date");

                if RentalPriceList.FindFirst() then
                    Validate("Daily Rate", RentalPriceList."Daily Rate")
                else begin
                    if RentalType."Daily Rate" < 0 then
                        Error('Osnovna cena za tip kolesa ne sme biti negativna.');

                    Validate("Daily Rate", RentalType."Daily Rate");
                end;

                if RentalHeader."Rental Date" <> 0D then
                    Validate(
                        "Rental Days",
                        RentalHeader."Expected Return Date" -
                        RentalHeader."Rental Date" + 1);

                UpdateLineAmount();
            end;
        }

        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(5; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            DataClassification = CustomerContent;
            MinValue = 0;

            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }

        field(6; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';
            DataClassification = CustomerContent;
            MinValue = 1;

            trigger OnValidate()
            begin
                UpdateLineAmount();
            end;
        }

        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            FieldClass = Normal;
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Rental No.", "Line No.")
        {
            Clustered = true;
        }
    }

    local procedure UpdateLineAmount()
    begin
        "Line Amount" := "Daily Rate" * "Rental Days";
    end;
}