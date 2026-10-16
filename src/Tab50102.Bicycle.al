table 50102 Bicycle
{
    Caption = 'Bicycle';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Rental Type Code"; Code[20])
        {
            Caption = 'Rental Type Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Rental Type".Code;

            trigger OnValidate()
            var
                RentalType: Record "Rental Type";
            begin
                if RentalType.Get("Rental Type Code") then
                    Description := RentalType.Description;
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Status; Enum "Bicycle Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            InitValue = Available;
        }
        field(5; "Purchase Date"; Date)
        {
            Caption = 'Purchase Date';
            DataClassification = CustomerContent;
        }
        field(6; "Purchase Price"; Decimal)
        {
            Caption = 'Purchase Price';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(7; "Current Location"; Text[100])
        {
            Caption = 'Current Location';
            DataClassification = CustomerContent;
        }
        field(8; "Last Service Date"; Date)
        {
            Caption = 'Last Service Date';
            DataClassification = CustomerContent;
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

