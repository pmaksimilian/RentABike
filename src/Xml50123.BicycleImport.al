
xmlport 50123 "Bicycle Import"
{
    Caption = 'Bicycle Import';
    Direction = Import;
    Format = Xml;

    schema
    {
        textelement(Bicycles)
        {
            tableelement(Bicycle; Bicycle)
            {
                XmlName = 'Bicycle';

                fieldelement(No; Bicycle."No.")
                {
                }

                fieldelement(RentalType; Bicycle."Rental Type Code")
                {
                }

                fieldelement(Description; Bicycle.Description)
                {
                }


                trigger OnBeforeInsertRecord()
                var
                    RentalType: Record "Rental Type";
                    ExistingBicycle: Record Bicycle;
                begin
                    if Bicycle."No." = '' then begin
                        CurrXMLport.Skip();
                        exit;
                    end;

                    if (Bicycle."Rental Type Code" = '') or
                    (not RentalType.Get(Bicycle."Rental Type Code"))
                    then begin
                        CurrXMLport.Skip();
                        exit;
                    end;

                    if ExistingBicycle.Get(Bicycle."No.") then begin
                        CurrXMLport.Skip();
                        exit;
                    end;

                    Bicycle.Status := Bicycle.Status::Available;
                end;

            }
        }
    }
}
