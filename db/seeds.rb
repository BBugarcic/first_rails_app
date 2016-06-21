# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.create(:name => "Racing bicycle",
:description => "3 years old. In very good condition.",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1920/v1466535474/bicycle-403464_1920_cquovq.jpg",
:color => "darkgrey")

Product.create(:name => "John Deer",
:description => "6 months old. In good condition. Like new",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1290/v1466536478/bicycle-274549_1280_crmtt2.jpg",
:color => "black green")

Product.create(:name => "City bike",
:description => "18 gears. In good condition. New ",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1290/v1466536282/bicycle-89476_1280_cby0kv.jpg",
:color => "black")

Product.create(:name => "City bike for ladies",
:description => "Like on the picture.",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1920/v1466536148/bicycle-1438390_1280_v55mmz.jpg",
:color => "gray")

Product.create(:name => "2 city bikes",
:description => "6 months old. Almost as new. Price is for one.",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1290/v1466536392/urban-1408168_1280_l3ae1f.jpg",
:color => "black")

Product.create(:name => "Racing bicycle",
:description => "In good condition. Suitable for kids and teenagers",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1920/v1466535626/bike-824417_1280_qc5avl.jpg",
:color => "blue yellow")

Product.create(:name => "City bike",
:description => "2 years old. Like new.",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1920/v1466535839/bicycle-789648_1280_fiqwxy.jpg",
:color => "black")

Product.create(:name => "City bike",
:description => "Like new",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1290/v1466536023/bicycle-407215_1280_ubhxei.jpg",
:color => "green")

Product.create(:name => "Racing bicycle",
:description => "Competely new. Not used.",
:image_url => "http://res.cloudinary.com/dnkyfvpgn/image/upload/c_scale,h_1080,w_1920/v1466536642/cycling-266032_1920_n91spm.jpg",
:color => "black white blue")
