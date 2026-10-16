namespace ALProject.ALProject;

using Microsoft.Sales.Customer;

pageextension 50121 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            group("Rental Information")
            {
                Caption = 'Rental Information';

                field("Preferred Rental Type"; Rec."Preferred Rental Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s preferred bicycle rental type.';
                }

                field("VIP Customer"; Rec."VIP Customer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the customer is a VIP customer.';
                }

                field("Max Active Rentals"; Rec."Max Active Rentals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of active rentals allowed for this customer.';
                }
            }
        }
    }
}

