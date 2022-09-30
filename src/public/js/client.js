$(() => {
    $('.remove-client').on('click',function () {
        const id = $(this).data('id')
        const name = $(this).closest('tr').find('.name-js').text()
        showWarning('اخطار حذف مشتری',`آیا برای حذف “${name}” مطمئن هستید؟`,'بله، حذف مشتری',() => {
            showLoading();
            sendAjax('/dashboard/client/delete',{id},(res) => {
                showSuccess(res.message)

                setTimeout(() => {
                    location.reload()
                },2000)
            })
        })
    })

    $(".edit-js").on("click",function(){
        // console.log('ok123')
        const parentRow = $(this).closest('tr')
        const name = parentRow.find(".name-js").text()

        $(".custoemr-edit-modal #name").val(name)
        $(".custoemr-edit-modal #number").val(parentRow.find(".number-js").text())
        $(".custoemr-edit-modal #address").val(parentRow.find(".address-js").text())

        $(".custoemr-edit-modal #date").val(parentRow.find(".birth-js").text().replaceAll('/','-'))

        $('.custoemr-edit-modal .customer_name').text(name)

        $('.custoemr-edit-modal .btn-modal-edit').data('id',$(this).data('id'))
    })

    $('.custoemr-edit-modal .btn-modal-edit').on('click',function () {
        // console.log($(".custoemr-edit-modal #name"))
        const name =  $(".custoemr-edit-modal #name").val()
        const phone =  $(".custoemr-edit-modal #number").val()
        let address =  $(".custoemr-edit-modal #address").val()
        const birthdayAlt =  $(".observer-example-alt").val()
        const birthdayInput = $('.custoemr-edit-modal #date').val()
        const id = $(this).data('id')

        let birthday = undefined;

        if(address==='ندارد') {
            address = ''
        }

        if(birthdayInput === 'ندارد'){
            birthday = undefined;
        }else {
            if(birthdayAlt) {
                birthday = birthdayAlt;
            } else {
                birthday = birthdayInput
            }
        }


        showLoading()
        sendAjax('/dashboard/client/edit',{fullName:name,phoneNumber:phone,address,birthday,id},(res) => {
            showSuccess(res.message)
            setTimeout(() => {
                location.reload()
            },2000)
        })
    })

    $('.initial-value-type-example').persianDatepicker({
        initialValueType: 'persian',
        position: [-310, 0],
        observer: true,
        format: 'YYYY-MM-DD',
        altField: '.observer-example-alt'
    });
})