// class = "ratings"の子要素を取得
stars = document.querySelector(".ratings").children;
// id = "rating-value"の要素を取得
ratingValue = document.getElementById("rating-value");
// id = "rating-value-display"の要素を取得
ratingValueDisplay = document.getElementById("rating-value-display");
// indexという変数を定義
var index;


// reveiwの投稿ページに遷移するとstars.lengthの値（5）だけ繰り返し
for(let i=0; i<stars.length; i++){
	console.log(stars.length)
	// 星にカーソルが乗ったときに実行する関数を定義
	stars[i].addEventListener("mouseover",function(){
		// stars.lengthの値（5）だけ繰り返し
		// つまり、星カーソルが乗った時、5回繰り返される
		for(let j=0; j<stars.length; j++){
			console.log(stars.length)
			// まず全て星をくり抜く
			stars[j].classList.remove("fa-star");
			stars[j].classList.add("fa-star-o");
		}
		// そのあと星の数だけ以下の関数が繰り返される。
		for(let j=0; j<=i; j++){
			console.log(stars.length)
			stars[j].classList.remove("fa-star-o");
			// カーソルが乗った星まで星を塗りつぶす
			stars[j].classList.add("fa-star");
		}
	})
	// クリックされた星の番号+1をratingValueに代入
	stars[i].addEventListener("click",function(){
		ratingValue.value = i+1;
		ratingValueDisplay.textContent = ratingValue.value;
		// indexにクリックされた星の番号を代入
		index = i;
	})
	// 星からカーソルが離れたときに実行される関数
	stars[i].addEventListener("mouseout",function(){
		// まず5回繰り返す
		for(let j=0; j<stars.length; j++){
			// まず全ての星をくり抜く
			stars[j].classList.remove("fa-star");
			stars[j].classList.add("fa-star-o");
		}
		for(let j=0; j<=index; j++){
			// クリックされている星まで塗りつぶす
			stars[j].classList.remove("fa-star-o");
			stars[j].classList.add("fa-star");
		}
	})
}