10.times do
  Supplier.create_fake
end

100.times do
  Product.create_fake
end

300.times do
  Image.create_fake
end