window.onload = function () {
    const toastLiveExample = document.getElementById('liveToast');
    if (toastLiveExample) {
        const toastBootstrap = new bootstrap.Toast(toastLiveExample);
        toastBootstrap.show();
    }
};