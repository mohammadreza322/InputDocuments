$(() => {
    $('.remove-client').on('click',function () {
        const name = $(this).closest('tr').find('.name-js').text()
        const id = $(this).data('id')
        showWarning('اخطار حذف مشتری',`آیا برای حذف “${name}” مطمئن هستید؟`,'بله',() => {
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
        const parentRow = $(this).closest('.table-row')
        const name = parentRow.find(".name-js").text()

        $(".edit-customer-modal #name").val(name)
        $(".edit-customer-modal #number").val(parentRow.find(".number-js").text())
        $(".edit-customer-modal #address").val(parentRow.find(".address-js").text())

        $(".edit-customer-modal #date").val(parentRow.find(".birth-js").text().replaceAll('/','-'))

        $('.edit-customer-modal .customer_name').text(name)

        $('.edit-customer-modal .btn-modal-edit').data('id',$(this).data('id'))
    })

    $('.edit-customer-modal .btn-modal-edit').on('click',function () {
        const name =  $(".edit-customer-modal #name").val()
        const phone =  $(".edit-customer-modal #number").val()
        let address =  $(".edit-customer-modal #address").val()
        const birthdayAlt =  $(".observer-example-alt").val()
        const birthdayInput = $('.edit-customer-modal #date').val()
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