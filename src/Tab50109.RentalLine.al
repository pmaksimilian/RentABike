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
                RentalType: Record "Rental Type";
                RentalHeader: Record "Rental Header";
            begin
                if not BicycleRec.Get("Bicycle No.") then
                    exit;

                if BicycleRec.Status <> BicycleRec.Status::Available then
                    Error('Only available bicycles can be rented.');

                Description := BicycleRec.Description;

                if RentalType.Get(BicycleRec."Rental Type Code") then
                    Validate("Daily Rate", RentalType."Daily Rate");

                if RentalHeader.Get("Rental No.") then
                    if (RentalHeader."Rental Date" <> 0D) and
                    (RentalHeader."Expected Return Date" <> 0D)
                    then
                        Validate(
                            "Rental Days",
                            RentalHeader."Expected Return Date" -
                            RentalHeader."Rental Date");
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