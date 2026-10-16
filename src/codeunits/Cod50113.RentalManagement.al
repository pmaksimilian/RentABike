codeunit 50113 "Rental Management"
{
    procedure StartRental(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        BicycleRec: Record Bicycle;
        CustomerRec: Record Customer;
        ActiveRentalHeader: Record "Rental Header";
        ActiveRentalCount: Integer;
    begin
        // 0. Preverjanje stranke iz faze 5
        if not CustomerRec.Get(RentalHeader."Customer No.") then
            Error('Stranke izposoje ni mogoče najti.');

        ActiveRentalHeader.SetRange("Customer No.", RentalHeader."Customer No.");
        ActiveRentalHeader.SetRange(Status, ActiveRentalHeader.Status::Active);

        ActiveRentalCount := ActiveRentalHeader.Count();

        if ActiveRentalCount >= CustomerRec."Max Active Rentals" then
            Error(
                'Stranka je že dosegla maksimalno dovoljeno število aktivnih izposoj.');


        // 1. Preveri status izposoje.
        if RentalHeader.Status <> RentalHeader.Status::Open then
            Error('Izposojo lahko začnemo samo, če je njen status Open.');

        // 2. Poišči vrstice trenutne izposoje.
        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        if RentalLine.IsEmpty() then
            Error('Izposoja mora vsebovati vsaj eno vrstico.');

        // 3. Najprej preveri vsa kolesa, brez spreminjanja podatkov.
        if RentalLine.FindSet() then
            repeat
                if not BicycleRec.Get(RentalLine."Bicycle No.") then
                    Error(
                        'Kolo %1 ne obstaja.',
                        RentalLine."Bicycle No.");

                if BicycleRec.Status <> BicycleRec.Status::Available then
                    Error(
                        'Kolo %1 ni na voljo.',
                        RentalLine."Bicycle No.");
            until RentalLine.Next() = 0;

        // 4. Vsa preverjanja so uspešna. Spremeni status koles.
        if RentalLine.FindSet() then
            repeat
                BicycleRec.Get(RentalLine."Bicycle No.");
                BicycleRec.Validate(Status, BicycleRec.Status::Rented);
                BicycleRec.Modify(true);
            until RentalLine.Next() = 0;

        // 5. Spremeni status izposoje.
        RentalHeader.Validate(Status, RentalHeader.Status::Active);
        RentalHeader.Modify(true);
    end;

    procedure ProcessReturn(var RentalHeader: Record "Rental Header")
    var
        RentalLine: Record "Rental Line";
        BicycleRec: Record Bicycle;
        RentalDays: Integer;
    begin
        // 1. Preveri status izposoje.
        if RentalHeader.Status <> RentalHeader.Status::Active then
            Error('Vrnemo lahko samo izposojo s statusom Active.');

        // 2. Preveri, ali izposoja vsebuje vrstice.
        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        if RentalLine.IsEmpty() then
            Error('Izposoja mora vsebovati vsaj eno vrstico.');

        // 3. Preveri, ali vsa navedena kolesa obstajajo.
        if RentalLine.FindSet() then
            repeat
                if not BicycleRec.Get(RentalLine."Bicycle No.") then
                    Error(
                        'Kolo %1 ne obstaja.',
                        RentalLine."Bicycle No.");
            until RentalLine.Next() = 0;

        // 4. Izračunaj število dni izposoje. Če je rezultat manjši od 1, ga nastavi na 1.
        RentalDays :=
            Today() - RentalHeader."Rental Date" + 1;
        if RentalDays < 1 then
            RentalDays := 1;

        // 5. Kolesa označi kot razpoložljiva.
        if RentalLine.FindSet() then
            repeat
                BicycleRec.Get(RentalLine."Bicycle No.");
                BicycleRec.Validate(
                    Status,
                    BicycleRec.Status::Available);
                BicycleRec.Modify(true);

                RentalLine.Validate("Rental Days", RentalDays);
                RentalLine.Modify(true);
            until RentalLine.Next() = 0;

        // 6. Zabeleži vračilo in spremeni status glave.
        RentalHeader.Validate("Actual Return Date", Today());
        RentalHeader.Validate(Status, RentalHeader.Status::Returned);
        RentalHeader.Modify(true);
    end;

    procedure CreateSalesInvoice(RentalHeader: Record "Rental Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RentalLine: Record "Rental Line";
        LineNo: Integer;
    begin
        // Preveri stranko.
        if RentalHeader."Customer No." = '' then
            Error('Izposoja nima določene stranke.');

        // Preveri, ali ima izposoja vsaj eno vrstico.
        RentalLine.SetRange("Rental No.", RentalHeader."No.");

        if not RentalLine.FindSet() then
            Error('Izposoja nima nobene vrstice.');

        // Ustvari glavo prodajnega računa.
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", RentalHeader."Customer No.");
        SalesHeader.Validate("Document Date", Today());
        SalesHeader.Modify(true);

        // Ustvari prodajno vrstico za vsako vrstico izposoje.
        repeat
            LineNo += 10000;

            SalesLine.Init();
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := LineNo;
            SalesLine.Insert(true);

            SalesLine.Validate(Type, SalesLine.Type::Item);
            SalesLine.Validate("No.", 'RENTAL');
            SalesLine.Validate(Description, RentalLine.Description);
            SalesLine.Validate(Quantity, RentalLine."Rental Days");
            SalesLine.Validate("Unit Price", RentalLine."Daily Rate");
            SalesLine.Modify(true);
        until RentalLine.Next() = 0;

        Message(
            'Prodajni račun %1 je bil ustvarjen.',
            SalesHeader."No.");
    end;

}