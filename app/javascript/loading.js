import $ from 'jquery'
window.$ = $
window.jQuery = $

document.addEventListener('turbo:load', function () {

  const loader = $('.loader-wrap');

  if (loader.length > 0) {
    loader.fadeOut(); // 即座に非表示
    setTimeout(() => loader.fadeOut(600), 4000); // 念のため2秒後も非表示
  } 
  else {
    console.warn(".loader-wrap not found");
  }
});