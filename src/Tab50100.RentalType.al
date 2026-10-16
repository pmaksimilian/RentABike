table 50100 "Rental Type"
{
    Caption = 'Rental Type';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            MinValue = 0;
        }
        field(4; "Max Rental Days"; Integer)
        {
            Caption = 'Max Rental Days';
            MinValue = 1;
        }
        field(5; "Requires Deposit"; Boolean)
        {
            Caption = 'Requires Deposit';
        }
        field(6; "Deposit Amount"; Decimal)
        {
            Caption = 'Deposit Amount';
            MinValue = 0;

            trigger OnValidate()
            begin
                if Rec."Requires Deposit" and
                   ("Deposit Amount" <= 0)
                then
                    Error(
                        'Deposit Amount must be greater than 0 when a deposit is required.');
            end;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
