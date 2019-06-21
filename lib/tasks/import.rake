namespace :import do
  desc "Custom: Import Data From MS SQL 2008 R2 - ACCPAC PEN001 database"
  
  require 'tiny_tds'

  task invoices: :environment do
    
    puts 'Starting connection to SQL Server...'
    client = TinyTds::Client.new(
                  host: '192.168.1.8', 
                  port:  '1433', 
                  username: 'readonly', 
                  password: '12345678', 
                  database: 'PEN001'
                  )
    
    puts 'Connecting to SQL Server...'
    
    if client.active? == true then
      puts 'Connected to SQL Server!' 
    end 

    puts "Reading data from MSSQL Server tables..."

        sql = "SELECT     RTRIM(I.INVNUMBER) AS invoice_id,
                          RTRIM(I.CUSTOMER) AS customer_id,
                          RTRIM(I.ORDNUMBER) AS order_id,
                          RTRIM(D.ITEM) AS item_id,
                          RTRIM(D.QTYORDERED) AS order_qty,
                          RTRIM(D.QTYBACKORD) AS backorder_qty,
                          RTRIM(D.QTYSHIPPED) AS shipped_qty,
                          RTRIM(D.PRIUNTPRC) AS unit_price,
                          RTRIM(D.EXTINVMISC) AS invoice_price,
                          RTRIM(I.INVFISCYR) AS fiscal_year,
                          RTRIM(I.INVFISCPER) AS fiscal_month,
                          RTRIM(I.INVDATE) AS invoice_date,
                          RTRIM(I.SALESPER1) AS sales_person_id        
              FROM        PEN001.dbo.OEINVH I
              INNER JOIN  PEN001.dbo.OEINVD D ON I.INVUNIQ = D.INVUNIQ
              WHERE       INVFISCYR IN ('2020')
              ORDER BY    I.INVDATE DESC"

    result = client.execute(sql)

    if result == [] then 
      puts "ERROR: SQL query has not return data!"
    end

    r = result.each

    if result.affected_rows > 0 then
      puts "#{result.affected_rows} row(s) affected in MSSQL Server"
    end

    result.cancel

    puts 'Closing connection to SQL Server...'
    
    client.close

    puts "Total Invoices records to import: #{r.size}"
    
    Invoice.import r, validate: true

    puts "Total Rails Invoices table records imported: #{Invoice.all.count}"
  end

  # Customer import
  task customers: :environment do

    puts 'Starting connection to SQL Server...'
    client = TinyTds::Client.new(
                  host: '192.168.1.8', 
                  port:  '1433', 
                  username: 'readonly', 
                  password: '12345678', 
                  database: 'PEN001'
                  )

    puts 'Connecting to SQL Server...'

    if client.active? == true then
      puts 'Connected to SQL Server!' 
    end 

    puts "Reading data from MSSQL Server tables..."

        sql = "SELECT RTRIM(IDCUST) AS customer_id,
                      RTRIM(NAMECUST) AS customer_name,
                      RTRIM(IDGRP) AS group_id,
                      RTRIM(NAMECITY) AS city,
                      RTRIM(CODESTTE) AS state,
                      RTRIM(CODEPSTL) AS postcode,
                      RTRIM(PRICLIST) AS pricelist,
                      RTRIM(DATESTART) AS start_date
              FROM    PEN001.dbo.ARCUS
              WHERE   SWACTV = 1"

    result = client.execute(sql)

    if result == [] then 
      puts "ERROR: SQL query has not return data!"
    end

    r = result.each

    if result.affected_rows > 0 then
      puts "#{result.affected_rows} row(s) affected in MSSQL Server"
    end

    result.cancel

    puts 'Closing connection to SQL Server...'

    client.close

    puts "Total Customers records to import: #{r.size}"

    Customer.import r, validate: true

    puts "Total Rails Dim_Customers table records imported: #{Customer.all.count}"
  end
end