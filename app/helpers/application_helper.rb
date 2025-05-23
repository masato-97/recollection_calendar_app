module ApplicationHelper
  def page_title(title = "")
    base_title = "Recordi"
    title.present? ? "#{title} - #{base_title}" : base_title
  end

  def default_meta_tags
    {
      description: "思い出の記録・評価・共有ができるWebアプリです。Recordi（レコルディ）で、思い出を記録し、1〜5個の星で思い出を評価し、他の人と共有しましょう。思い出の記録だけでなく、場所、作品、料理などを記録しレビューアプリとして使用することもできます。",
      keywords: "思い出,旅行,料理,グルメ,映画,本,漫画,レビュー,共有",
      canonical: "https://recordi.jp",
      og: {
        site_name: "Recordi",
        title: :title,
        description: :description,
        type: "website",
        url: "https://recordi.jp",
        image: image_url("ogp.png"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        image: image_url("ogp.png")
      }
    }
  end
end
