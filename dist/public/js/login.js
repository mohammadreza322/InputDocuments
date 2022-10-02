$(() => {
    $('.login').on('submit',function (e) {
        e.preventDefault();
        const phoneNumber = $('#inputEmail').val()

        showLoading()


        sendAjax('/api/get-mobile',
            {phoneNumber:phoneNumber},
            (res) => {
                showSuccess(res.message);
                setTimeout(() => {
                    location.replace('/dashboard/auth/otp')
                },1500)
        })
    })
})