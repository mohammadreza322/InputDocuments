$(document).ready(function () {
    function generatePassword() {

        let chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        let string_length = 8;
        let randomstring = '';
        for (let i=0; i<string_length; i++) {
            let rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum,rnum+1);
        }
        return randomstring
    }
    $("#random").on("click",function(){
        const randomstring = generatePassword()
        $("#pass").val(randomstring)

    })

    $("#slide-up").on("click",function(){
        $("#add").slideUp("slow");
        $('#slide-down').show("fast")
    });
    $("#slide-down").on("click",function(){

        $(this).hide("fast")
        $("#add").slideDown("slow",function () {

        });
    });

    $('.device-type').on('change',function () {
        let preSerialNumber = ' -chc'

        if(this.value == 'power'){
            preSerialNumber = ' -chp'
        }



        $('.static-te').text(preSerialNumber)
    })

    $('.add-device-btn').on('click',function () {
        const serialNumber = $('#name').val()
        const password = $('#pass').val()
        const type = $('.device-type').val()

        showLoading()
        sendAjax('/dashboard/store_room/add',{serialNumber,password,type},function (res) {
            showSuccess(res.message)
            setTimeout(() => {
                location.reload()
            },2000)
        })
    })

    $('.delete-device').on('click',function () {
        const serialNumber = $(this).data('id')
        const type = $(this).data('type')

        showWarning('اخطار حذف دستگاه',`آیا برای حذف “${serialNumber}” مطمئن هستید؟`,'بله',() => {
            showLoading()
            sendAjax('/dashboard/store_room/delete',{serialNumber,type},(res) => {
                showSuccess(res.message)
                setTimeout(() => {
                    location.reload()
                },2000)
            })
        })
    })
})