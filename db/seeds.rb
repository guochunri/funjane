# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 新增品牌 - Brand #

brand_name = [
  'FunJane',
  'Yoshida Porter',
  'MUJI',
  'MONOCLE',
  'CLASSICO',
  'Champion',
  'URBAN RESEARCH'
]

create_brands = for i in 1..5 do
  Brand.create!(
  name: brand_name[rand(brand_name.length)],
  description: 'About',
  logo: 'No image'
  )
end

puts '创建品牌*5'

# 新增分類 - Category #

Category.create!(
  name: '刺绣',
  category_group_id: 1
)

Category.create!(
  name: '叮当',
  category_group_id: 2
)

Category.create!(
  name: '三变恐龙',
  category_group_id: 2
)

puts '创建分类*3'

# 新增大分类 - CategoryGroup #

CategoryGroup.create!(
  name: '手工艺品'
)

CategoryGroup.create!(
  name: '积木'
)

puts '創建大類別*2'
