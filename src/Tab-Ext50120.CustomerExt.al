namespace ALProject.ALProject;

using Microsoft.Sales.Customer;


tableextension 50120 "Customer Ext" extends Customer
{
    fields
    {
        field(50119; "Preferred Rental Type"; Code[20])
        {
            Caption = 'Preferred Rental Type';
            DataClassification = CustomerContent;
            TableRelation = "Rental Type".Code;
        }

        field(50120; "VIP Customer"; Boolean)
        {
            Caption = 'VIP Customer';
            DataClassification = CustomerContent;
        }

        field(50121; "Max Active Rentals"; Integer)
        {
            Caption = 'Max Active Rentals';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }
}

