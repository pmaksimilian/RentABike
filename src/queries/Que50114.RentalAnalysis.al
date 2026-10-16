query 50114 "Rental Analysis"
{
    Caption = 'Analiza izposoj';
    QueryType = Normal;
    UsageCategory = ReportsAndAnalysis;

    elements
    {
        dataitem(RentalHeader; "Rental Header")
        {
            DataItemTableFilter = Status = const(Active);

            column(RentalNo; "No.")
            {
                Caption = 'Številka izposoje';
            }

            column(CustomerNo; "Customer No.")
            {
                Caption = 'Številka stranke';
            }

            column(RentalStatus; Status)
            {
                Caption = 'Status izposoje';
            }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = RentalHeader."Customer No.";
                SqlJoinType = InnerJoin;

                column(CustomerName; Name)
                {
                    Caption = 'Ime stranke';
                }

                dataitem(RentalLine; "Rental Line")
                {
                    DataItemLink = "Rental No." = RentalHeader."No.";
                    SqlJoinType = InnerJoin;

                    column(RentalDays; "Rental Days")
                    {
                        Caption = 'Dnevi izposoje';
                    }

                    column(LineAmount; "Line Amount")
                    {
                        Caption = 'Znesek vrstice';
                    }

                    dataitem(Bicycle; Bicycle)
                    {
                        DataItemLink = "No." = RentalLine."Bicycle No.";
                        SqlJoinType = InnerJoin;

                        column(BicycleNo; "No.")
                        {
                            Caption = 'Številka kolesa';
                        }

                        column(BicycleDescription; Description)
                        {
                            Caption = 'Opis kolesa';
                        }
                    }
                }
            }
        }
    }
}