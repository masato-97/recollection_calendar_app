module ApplicationHelper
  def default_meta_tags
    {
      site: "Recordi（レコルディ）",
      title: "思い出の記録・評価・共有ができるサービス",
      reverse: true,
      charset: "utf-8",
      description: "Recordi（レコルディ）とは、思い出の記録、1〜5個の星で思い出を評価、思い出を他のユーザーに共有することができるサービスです。思い出の記録だけでなく、場所、作品、料理などを記録しレビューアプリとして使用することもできます。",
      keywords: "思い出,旅行,料理,グルメ,映画,本,漫画,レビュー,共有",
      canonical: "https://recordi.jp",
      separator: "|",
      og: {
        site_name: :site,
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
