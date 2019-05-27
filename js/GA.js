
function loadjsfile(filename){
    var file_ref=document.createElement('script')
    file_ref.setAttribute("type","text/javascript")
    file_ref.setAttribute("src", filename)
    if (typeof file_ref!="undefined")
        document.getElementsByTagName("head")[0].appendChild(file_ref);
}

loadjsfile("https://www.googletagmanager.com/gtag/js?id=UA-140888363-1")

window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', 'UA-140888363-1');
