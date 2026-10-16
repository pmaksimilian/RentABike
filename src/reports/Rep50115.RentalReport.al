
report 50115 "Rental Report"
{
    Caption = 'Pregled izposoj po strankah';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RentalWordLayout;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            column(CustomerNo; "No.")
            {
            }

            column(CustomerName; Name)
            {
            }

            dataitem(RentalHeader; "Rental Header")
            {
                DataItemLink = "Customer No." = field("No.");

                column(RentalNo; "No.")
                {
                }

                column(RentalDate; "Rental Date")
                {
                }

                column(ExpectedReturnDate; "Expected Return Date")
                {
                }

                column(ActualReturnDate; "Actual Return Date")
                {
                }

                column(RentalStatus; Status)
                {
                }

                dataitem(RentalLine; "Rental Line")
                {
                    DataItemLink = "Rental No." = field("No.");

                    column(BicycleNo; "Bicycle No.")
                    {
                    }

                    column(RentalDays; "Rental Days")
                    {
                    }

                    column(DailyRate; "Daily Rate")
                    {
                    }

                    column(LineAmount; "Line Amount")
                    {
                    }

                    column(BicycleDescription; BicycleDescription)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        BicycleRec: Record Bicycle;
                    begin
                        Clear(BicycleDescription);

                        if BicycleRec.Get("Bicycle No.") then
                            BicycleDescription := BicycleRec.Description;

                        CustomerTotal += "Line Amount";
                        GrandTotal += "Line Amount";
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    RentalCount += 1;
                end;
            }

            dataitem(CustomerTotals; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = const(1));

                column(CustomerTotalAmount; CustomerTotal)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CustomerTotal := 0;
            end;
        }

        dataitem(ReportTotals; Integer)
        {
            DataItemTableView = sorting(Number)
                                where(Number = const(1));

            column(GrandTotalAmount; GrandTotal)
            {
            }

            column(PrintDate; Today)
            {
            }

            column(CompanyNameColumn; CompanyName())
            {
            }
        }
    }

    requestpage
    {
        AboutTitle = 'Pregled izposoj';
        AboutText = 'Izpis izposoj po strankah s podrobnostmi in zneski.';
    }

    rendering
    {
        layout(RentalWordLayout)
        {
            Type = Word;
            Caption = 'Pregled izposoj - Word';
            Summary = 'Poslovni izpis izposoj po strankah';
            LayoutFile = 'RentalReport.docx';
        }
    }

    var
        BicycleDescription: Text[100];
        CustomerTotal: Decimal;
        GrandTotal: Decimal;
        RentalCount: Integer;
}
