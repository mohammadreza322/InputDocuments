let digitValidate = function(ele){
  
    ele.value = ele.value.replace(/[^0-9]/g,'');
  }
  
  let tabChange = function(val){
 
      let ele = $('input');
      if(ele[val-1].value != ''&& val<5){   
        ele[val].focus()
      }else if(ele[val-1].value == '' && val>1){
        ele[val-2].focus()
      }   
   }

$(() => {
    $('.otp').on('submit',function (e) {
        e.preventDefault();
        const codeOne = $('#first').val()
        const codeTwo = $('#second').val()
        const codeThree = $('#third').val()
        const codeFour = $('#fourth').val()
        const codeFive = $('#fifth').val()
        const code = codeOne+codeTwo+codeThree+codeFour+codeFive
        const id = $(this).data('id')

        showLoading()

        sendAjax('/auth/check-otp',{code,smsId:id,isDashboard:true},(res) => {
            // showSuccess(res.message);
            setTimeout(() => {
                location.replace('/')
            },1500)
        })
    })
})