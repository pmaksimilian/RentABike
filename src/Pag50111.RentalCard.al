namespace ALProject.ALProject;

page 50111 "Rental Card"
{
    PageType = Card;
    SourceTable = "Rental Header";
    Caption = 'Rental Card';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Rental Date"; Rec."Rental Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Return Date"; Rec."Actual Return Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part(RentalLines; "Rental Line Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Rental No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(StartRental)
            {
                Caption = 'Start Rental';
                ApplicationArea = All;
                ToolTip = 'Začne izposojo in označi kolesa kot izposojena.';

                trigger OnAction()
                var
                    RentalManagement: Codeunit "Rental Management";
                begin
                    RentalManagement.StartRental(Rec);
                    CurrPage.Update(false);
                end;
            }

            action(ProcessReturn)
            {
                Caption = 'Process Return';
                ApplicationArea = All;
                ToolTip = 'Zaključi izposojo in označi kolesa kot razpoložljiva.';

                trigger OnAction()
                var
                    RentalManagement: Codeunit "Rental Management";
                begin
                    RentalManagement.ProcessReturn(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
