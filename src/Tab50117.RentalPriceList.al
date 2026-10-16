
table 50117 "Rental Price List"
{
    Caption = 'Rental Price List';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(3; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Rental Type".Code;

            trigger OnValidate()
            begin
                CheckOverlappingPeriod();
            end;
        }

        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDateRange();
                CheckOverlappingPeriod();
            end;
        }

        field(5; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDateRange();
                CheckOverlappingPeriod();
            end;
        }

        field(6; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            DataClassification = CustomerContent;
            MinValue = 0;
            DecimalPlaces = 0 : 2;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }

        key(RentalTypePeriod; "Rental Type Code", "Starting Date", "Ending Date")
        {
        }
    }

    trigger OnInsert()
    begin
        CheckDateRange();
        CheckOverlappingPeriod();
    end;

    trigger OnModify()
    begin
        CheckDateRange();
        CheckOverlappingPeriod();
    end;

    local procedure CheckDateRange()
    begin
        if ("Starting Date" <> 0D) and ("Ending Date" <> 0D) then
            if "Starting Date" > "Ending Date" then
                Error('Starting Date ne sme biti poznejši od Ending Date.');
    end;

    local procedure CheckOverlappingPeriod()
    var
        ExistingPriceList: Record "Rental Price List";
    begin
        if ("Rental Type Code" = '') or
           ("Starting Date" = 0D) or
           ("Ending Date" = 0D)
        then
            exit;

        ExistingPriceList.SetRange("Rental Type Code", "Rental Type Code");
        ExistingPriceList.SetFilter(Code, '<>%1', Code);
        ExistingPriceList.SetFilter("Starting Date", '<=%1', "Ending Date");
        ExistingPriceList.SetFilter("Ending Date", '>=%1', "Starting Date");

        if ExistingPriceList.FindFirst() then
            Error(
                'Za tip izposoje %1 že obstaja cenik, ki velja v izbranem časovnem obdobju.',
                "Rental Type Code");
    end;
}
