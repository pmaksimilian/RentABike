table 50108 "Rental Header"
{
    Caption = 'Rental Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Customer."No.";
        }

        field(3; "Rental Date"; Date)
        {
            Caption = 'Rental Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Expected Return Date" <> 0D) and
                   ("Expected Return Date" < "Rental Date")
                then
                    Error(
                        'Expected Return Date cannot be before Rental Date.');
            end;
        }

        field(4; "Expected Return Date"; Date)
        {
            Caption = 'Expected Return Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Rental Date" <> 0D) and
                   ("Expected Return Date" < "Rental Date")
                then
                    Error(
                        'Expected Return Date cannot be before Rental Date.');
            end;
        }

        field(5; "Actual Return Date"; Date)
        {
            Caption = 'Actual Return Date';
            DataClassification = CustomerContent;
        }

        field(6; Status; Enum "Rental Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            InitValue = Open;
        }

        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Rental Line"."Line Amount"
                where("Rental No." = field("No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}