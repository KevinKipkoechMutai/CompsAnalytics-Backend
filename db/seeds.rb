# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts " 🌱️ Seeding data..."

accounts = Account.create([
    {account_name: "Jevans", tokens: 100, account_number: 0712124565, account_email: "stan@gmail.com", password_digest: "123456789"}
])

transactions = Transaction.create([
    {transaction_code: 4356, amount: 500, account_name: "Jevans", account_number: 45679238957, payment_method: "cash", user_name: "Tito"}
])

properties = Properties.create([
    {title: "DiamondOak", image: "", lr_no: "1870/III/521", location: "Brookside Drive", category: "land", analysis: "383945046", description: "Vacant land", size: "0.65", value: "250000000"},
    {title: "SilverOak", image: "", lr_no: "1870/II/350", location: "General Mathenge Drive, Westlands", category: "land", analysis: "288027102", description: "Vacant land", size: "0.42", value: "120000000"},
    {title: "PremiumOak", image: "", lr_no: "1870/II/471", location: "General Mathenge Drive, Westlands", category: "land", analysis: "300000000", description: "Vacant land", size: "1.95", value: "585650700"},
    {title: "Lesedi", image: "", lr_no: "1870/II/213", location: "Peponi Grove ", category: "land", analysis: "300155056", description: "Vacant land", size: "0.75", value: "226000000"},
    {title: "Gumba", image: "", lr_no: "1870/III/218", location: "Brookside Drive", category: "land", analysis: "310693343", description: "Vacant land", size: "0.51", value: "160000000"},
    {title: "Kanairo", image: "", lr_no: "1870/II/351", location: "General Mathenge Drive", category: "land", analysis: "336031619", description: "Vacant land", size: "0.42", value: "140000000"}
])

puts "Done Seeding 🍂️"
