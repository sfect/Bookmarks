class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  before_save :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.name)
    category = Category.find_by slug: the_slug    # 同じスラッグのカテゴリーがすでにあるかどうかを確認
    count = 2
    while category && category != self            # すでにある場合は
      the_slug = append_suffix(the_slug, count)   # 下記のappend_suffixメソッドを使用
      category = Category.find_by slug: the_slug  # 変更されたスラッグと同じものがあるか確認
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0              # タイトルの最後の要素が数字の場合
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else                                          # タイトルの最後の要素が数字以外の場合
      return str + "-" + count                    #　カウンターの数字を追加
    end
  end

  def to_slug(name)
    str = name.strip                              # スペースを削除
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'           # アルファベット以外をダッシュに変換
    str.gsub! /-+/, "-"                           # 重複するダッシュを1つにまとめる
    self.slug = str.downcase                      # これがないと上のgsub!がnilを返してしまう
  end
end