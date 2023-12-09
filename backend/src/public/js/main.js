// function showError(text) {
//     swal.fire({
//         title: 'خطا',
//         text: text,
//         icon: 'error',
//         showDenyButton: true,
//         showConfirmButton: false,
//         denyButtonText: 'تایید'
//     })
// }
//
// function showSuccess(text) {
//     return swal.fire({
//         text: text,
//         icon: 'success',
//         showDenyButton: false,
//         showConfirmButton: true,
//         confirmButtonText: `تایید`
//     })
// }
// function showWarning(text, success) {
//     swal.fire({
//         text: text,
//         icon: 'warning',
//         showDenyButton: true,
//         denyButtonText: 'خیر',
//         confirmButtonText: `بله`
//     }).then((result) => {
//         if (result.isConfirmed) {
//             success()
//         }
//     })
// }

const token = document.querySelector('.ahp-secret').getAttribute('data-ahp')

function sendAjax(url, data = {}, success = () => {}, type = 'POST') {

    data['_csrf'] = token

    $.ajax({
        headers: {
            'x-csrf-token': token,
            'x-xsrf-token': token,
            'csrf-token': token,
            'xsrf-token': token,
            'Content-Type': 'application/json; charset=utf-8'
        },
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true,
        url: url + '?_csrf=' + token,
        data: JSON.stringify(data),

        dataType: 'json',
        type: type,
        success: (res) => {
            // swal.close()
            if (res.status) {
                success(res)
            } else {
                showError(res.message)
            }
        },
        error:(req,status,error) => {
            showError(JSON.parse(req.responseText).message)
        }
    })
}

// function showLoading() {
//     swal.fire({
//         html: 'لطفا صبر کنید',
//         allowEscapeKey: false,
//         allowOutsideClick: false,
//         didOpen: () => {
//             swal.showLoading()
//         }
//     });
// }
