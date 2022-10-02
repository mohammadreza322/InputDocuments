$(document).ready(function () {
  $(".navbar-nav");
  var btns = $(".nav-link");
  for (var i = 0; i < btns.length; i++) {
    btns[i].addEventListener("click", function () {
      var current = document.getElementsByClassName("active");
      current[0].className = current[0].className.replace(" active", "");
      this.className += " active";
    });
  }
  const tooltipTriggerList = document.querySelectorAll(
      '[data-bs-toggle="tooltip"]'
  );
  [...tooltipTriggerList].map(
      (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl,{
      })
  );

  $('.edit-profile .btn-modal-edit').on('click',function () {
    const name = $('.edit-profile #name').val()
    const phoneNumber = $('.edit-profile #number').val()

    showLoading()
    sendAjax('/dashboard/admin/current',{fullName:name,phoneNumber},(res) => {
      showSuccess(res.message)
      setTimeout(() => {
        location.reload()
      },1000)
    })
  })
});

window.onload = function () {
  setTimeout(() => {
    $('.header-loading').removeClass('animation')
  },500)
}

// loading modal
const loadingModal = new bootstrap.Modal($(".loadmodal"));
function showLoading(){
  const text = 'لطفا منتظر بمانید'
  successModal.hide()
  removeModal.hide()
  errormodal.hide()

  $(".loadmodal .text").text(text)

  loadingModal.show()
}

// success modal
const successModal = new bootstrap.Modal($(".successModal"));
function showSuccess(text){
  removeModal.hide()
  errormodal.hide()
  loadingModal.hide()

  $(".successModal .title").text('با موفقیت انجام شد');
  $(".successModal .text").text(text);
  successModal.show();
  $('.successModal .cancle').on("click",function(){
    successModal.hide()
  })
}
//  warning modal
const removeModal = new bootstrap.Modal($(".myModal"));
function showWarning(title, text, successText, success) {
  successModal.hide()
  errormodal.hide()
  loadingModal.hide()

  $(".myModal .title").text(title);
  $(".myModal .text").text(text);
  $('.myModal .accept').text(successText)


  $(".myModal .accept").on("click", function () {
    success();
  });

  $(".myModal .cancle").on("click", function () {
    removeModal.hide();
  });

  removeModal.show();
}
// error modal
const errormodal = new bootstrap.Modal($(".errormodal"));
function showError( text){

  successModal.hide()
  removeModal.hide()
  loadingModal.hide()
  const title = 'خطا'
  const successText = 'متوجه شدم'
  const cancelElement = $(".errormodal .cancle")
  $(".errormodal .title").text(title);
  $(".errormodal .text").text(text)
  cancelElement.text(successText)

  cancelElement.on("click", function () {
    errormodal.hide();
  });
  errormodal.show();
}
