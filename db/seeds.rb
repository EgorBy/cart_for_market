Product.destroy_all
Product.create([{name: 'Беспроводная колонка Goodyear Bluetooth Speaker', price: 1600, image_url: "https://i.ibb.co/qpVwB8y/product-1.png"},
                {name: 'Женский домашний костюм Sweet Dreams', price: 800, image_url: "https://i.ibb.co/m99SDzg/Image2.png"},
                {name: 'Плащ-дождевик SwissOak', price: 800, image_url: "https://i.ibb.co/PhkqHDV/Image.png"}])

puts "Total number of products: #{Product.count}"

