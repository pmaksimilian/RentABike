
page 50122 "Bicycle API"
{
    PageType = API;
    Caption = 'Bicycle API';

    APIPublisher = 'rentalcompany';
    APIGroup = 'bikerental';
    APIVersion = 'v1.0';

    EntityName = 'bicycle';
    EntitySetName = 'bicycles';

    SourceTable = Bicycle;
    ODataKeyFields = SystemId;

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'ID';
                }

                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }

                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }

                field(rentalType; Rec."Rental Type Code")
                {
                    Caption = 'Rental Type';
                }
            }
        }
    }
}
