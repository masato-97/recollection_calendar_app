// class = "ratings"の子要素を取得
// 子要素は要素数が５の配列で、フォームの <span class="fa fa-star-o" id="star"></span> が５つ入った配列を取得している
stars = document.querySelector(".ratings").children;

// id = "rating-value"の要素を取得
// フォームの <%= f.hidden_field :score, id: "rating-value" %> を取得している
ratingValue = document.getElementById("rating-value");

// id = "rating-value-display"の要素を取得
// フォームの <span id="rating-value-display">0</span> を取得している
ratingValueDisplay = document.getElementById("rating-value-display");

// indexという変数を定義
var index;

// 思い出作成・編集ページに遷移するとstars.lengthの値（5）だけ繰り返し
// stars.lengthは配列の長さなので５になる
for(let i=0; i<stars.length; i++){
	// 星にカーソルが乗ったときに実行する処理（関数）を定義
	// stars[i]は全ての星に対してという意味
	stars[i].addEventListener("mouseover",function(){
		// 星にカーソルが乗った時、全て星をくり抜く（星の色をなくす）
		// stars.lengthは５なので、５つ（全て）の星に対して実行
		for(let j=0; j<stars.length; j++){
			// classListは特定の要素にクラス名を追加したり削除したりできるプロパティ
			// "fa-star"を"fa-star-o"にする（クラスを変更する）
			stars[j].classList.remove("fa-star");
			stars[j].classList.add("fa-star-o");
		}

		// カーソルが乗った星まで星を塗りつぶす
		// 例：３つ目の星にカーソルが乗ったら３回（３つの星分）以下の処理を繰り返す
		// iはカーソルが乗っている星の値なので、３つ目の星の場合は値は２になる（０,1,２の３回処理する）
		for(let j=0; j<=i; j++){
			// "fa-star-o"を"fa-star"にする（クラスを変更する）
			stars[j].classList.remove("fa-star-o");
			stars[j].classList.add("fa-star");
		}
	})

	// 星をクリックしたときに処理を実行
	// 以下は、スコアを変更させる処理
	stars[i].addEventListener("click",function(){
		// クリックされた星の番号（i)に1をプラスし、ratingValue（スコア）に代入し、登録するスコアを変更
		ratingValue.value = i+1;
		// ratingValue を ratingValueDisplay に代入し、表示されるスコアを変更
		ratingValueDisplay.textContent = ratingValue.value;
		// クリックされた星の番号（i)を index に代入
		index = i;
	})

	// 星からカーソルが離れたときに実行される処理（関数）
	stars[i].addEventListener("mouseout",function(){
		// まず、全て星をくり抜く（星の色をなくす）
		// クラスを変更する処理を５回（５つの星分）繰り返す
		for(let j=0; j<stars.length; j++){
			stars[j].classList.remove("fa-star");
			stars[j].classList.add("fa-star-o");
		}

		// クリックされた星まで塗りつぶす
		// index はクリックされた星の番号（i)
		for(let j=0; j<=index; j++){
			// クラスを変更
			stars[j].classList.remove("fa-star-o");
			stars[j].classList.add("fa-star");
		}
	})
}