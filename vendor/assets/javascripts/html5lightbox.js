/** HTML5 LightBox - jQuery Image and Video LightBox Plugin
 * Copyright 2013 Magic Hills Pty Ltd All Rights Reserved
 * Website: http://html5box.com
 * Version 2.6
 */

function loadHtml5LightBox(jsFolder) {
    (function ($) {
        $.fn.html5lightbox = function (options) {
            var inst = this;
            inst.options = jQuery.extend({
                autoplay: true,
                html5player: false,
                closepos: "bottom",
                titlepos: "inside",
                overlaybgcolor: "#000000",
                overlayopacity: 0.9,
                bgcolor: 0,
                bordersize: 0,
                barheight: 36,
                loadingwidth: 64,
                loadingheight: 64,
                resizespeed: 400,
                fadespeed: 400,
                jsfolder: jsFolder,
                skinsfoldername: "/assets/skins/default/",
                loadingimage: "lightbox-loading.gif",
                nextimage: "lightbox-next.png",
                previmage: "lightbox-prev.png",
                closeimage: "lightbox-close.png",
                playvideoimage: "lightbox-playvideo.png",
                titlebgimage: "lightbox-titlebg.png",
                titlecss: "{color:#777; font-size:16px; font-family:Armata,sans-serif,Arial; overflow:hidden; }",
                errorwidth: 280,
                errorheight: 48,
                errorcss: "{text-align:center; color:#ff0000; font-size:14px; font-family:Arial, sans-serif;}",
                supportesckey: true,
                supportarrowkeys: true,
                version: "2.6",
                stamp: false,
                freemark: "html5box.com",
                freelink: "http://html5box.com/",
                watermark: "",
                watermarklink: ""
            }, options);
            if (typeof html5lightbox_options != "undefined" &&
                html5lightbox_options) jQuery.extend(inst.options, html5lightbox_options);
            inst.options.htmlfolder = window.location.href.substr(0, window.location.href.lastIndexOf("/") + 1);
            inst.options.skinsfolder = inst.options.skinsfoldername;
            if (inst.options.skinsfolder.length > 0 && inst.options.skinsfolder[inst.options.skinsfolder.length - 1] != "/") inst.options.skinsfolder += "/";
            if (inst.options.skinsfolder.charAt(0) != "/" && inst.options.skinsfolder.substring(0, 5) != "http:" && inst.options.skinsfolder.substring(0, 6) != "https:") inst.options.skinsfolder =
                inst.options.jsfolder + inst.options.skinsfolder;
            inst.options.types = ["IMAGE", "FLASH", "VIDEO", "YOUTUBE", "VIMEO", "PDF", "MP3", "WEB", "FLV"];
            inst.elemArray = new Array;
            inst.options.curElem = -1;
            inst.options.flashInstalled = false;
            try {
                if (new ActiveXObject("ShockwaveFlash.ShockwaveFlash")) inst.options.flashInstalled = true
            } catch (e) {
                if (navigator.mimeTypes["application/x-shockwave-flash"]) inst.options.flashInstalled = true
            }
            inst.options.html5VideoSupported = !! document.createElement("video").canPlayType;
            inst.options.isChrome =
                navigator.userAgent.match(/Chrome/i) != null;
            inst.options.isFirefox = navigator.userAgent.match(/Firefox/i) != null;
            inst.options.isOpera = navigator.userAgent.match(/Opera/i) != null || navigator.userAgent.match(/OPR\//i) != null;
            inst.options.isSafari = navigator.userAgent.match(/Safari/i) != null;
            inst.options.isIE = navigator.userAgent.match(/MSIE/i) != null && !inst.options.isOpera;
            inst.options.isIE9 = inst.options.isIE && inst.options.html5VideoSupported;
            inst.options.isIE678 = inst.options.isIE && !inst.options.isIE9;
            inst.options.isIE6 =
                navigator.userAgent.match(/MSIE 6/i) != null && !inst.options.isOpera;
            inst.options.isAndroid = navigator.userAgent.match(/Android/i) != null;
            inst.options.isIPad = navigator.userAgent.match(/iPad/i) != null;
            inst.options.isIPhone = navigator.userAgent.match(/iPod/i) != null || navigator.userAgent.match(/iPhone/i) != null;
            inst.options.isMobile = inst.options.isAndroid || inst.options.isIPad || inst.options.isIPhone;
            inst.options.isIOSLess5 = inst.options.isIPad && inst.options.isIPhone && (navigator.userAgent.match(/OS 4/i) != null ||
                navigator.userAgent.match(/OS 3/i) != null);
            inst.options.supportCSSPositionFixed = !inst.options.isIE6 && !inst.options.isIOSLess5;
            inst.options.resizeTimeout = -1;
            var inst = this;
            inst.init = function () {
                inst.showing = false;
                inst.readData();
                inst.createMarkup();
                inst.supportKeyboard()
            };
            var ELEM_TYPE = 0,
                ELEM_HREF = 1,
                ELEM_TITLE = 2,
                ELEM_GROUP = 3,
                ELEM_WIDTH = 4,
                ELEM_HEIGHT = 5,
                ELEM_HREF_WEBM = 6,
                ELEM_HREF_OGG = 7;
            inst.readData = function () {
                inst.each(function () {
                    if (this.nodeName.toLowerCase() != "a" && this.nodeName.toLowerCase() != "area") return;
                    var $this = $(this);
                    var fileType = inst.checkType($this.attr("href"));
                    if (fileType < 0) return;
                    for (var i = 0; i < inst.elemArray.length; i++)
                        if ($this.attr("href") == inst.elemArray[i][ELEM_HREF]) return;
                    inst.elemArray.push(new Array(fileType, $this.attr("href"), $this.attr("title"), $this.data("group"), $this.data("width"), $this.data("height"), $this.data("webm"), $this.data("ogg")))
                })
            };
            inst.createMarkup = function () {
                var fontRef = ("https:" == document.location.protocol ? "https" : "http") + "://fonts.googleapis.com/css?family=Armata";
                var fontLink = document.createElement("link");
                fontLink.setAttribute("rel", "stylesheet");
                fontLink.setAttribute("type", "text/css");
                fontLink.setAttribute("href", fontRef);
                document.getElementsByTagName("head")[0].appendChild(fontLink);
                var styleCss = "#html5-text " + inst.options.titlecss;
                styleCss += ".html5-error " + inst.options.errorcss;
                $("head").append("<style type='text/css'>" + styleCss + "</style>");
                inst.$lightbox = jQuery("<div id='html5-lightbox' style='display:none;top:0px;left:0px;width:100%;height:100%;z-index:9999999;'>" +
                    "<div id='html5-lightbox-overlay' style='display:block;position:absolute;top:0px;left:0px;width:100%;height:100%;background-color:" + inst.options.overlaybgcolor + ";opacity:" + inst.options.overlayopacity + ";filter:alpha(opacity=" + Math.round(inst.options.overlayopacity * 100) + ");'></div>" + "<div id='html5-lightbox-box' style='display:block;position:relative;margin:0px auto;'>" + "<div id='html5-elem-box' style='display:block;position:relative;margin:0px auto;text-align:center;'>" + "<div id='html5-elem-wrap' style='display:block;position:relative;margin:0px auto;text-align:center;background-color:" +
                    inst.options.bgcolor + ";'>" + "<div id='html5-loading' style='display:none;position:absolute;top:0px;left:0px;text-align:center;width:100%;height:100%;background:url(\"" + inst.options.skinsfolder + inst.options.loadingimage + "\") no-repeat center center;'></div>" + "<div id='html5-error' class='html5-error' style='display:none;position:absolute;padding:" + inst.options.bordersize + "px;text-align:center;width:" + inst.options.errorwidth + "px;height:" + inst.options.errorheight + "px;'>" + "The requested content cannot be loaded.<br />Please try again later." +
                    "</div>" + "<div id='html5-image' style='display:none;position:absolute;top:0px;left:0px;padding:" + inst.options.bordersize + "px;text-align:center;'></div>" + "<div id='html5-next' style='display:none;cursor:pointer;position:absolute;right:" + inst.options.bordersize + "px;top:40%;'><img src='" + inst.options.skinsfolder + inst.options.nextimage + "'></div>" + "<div id='html5-prev' style='display:none;cursor:pointer;position:absolute;left:" + inst.options.bordersize + "px;top:40%;'><img src='" + inst.options.skinsfolder +
                    inst.options.previmage + "'></div>" + "</div>" + "</div>" + "<div id='html5-watermark' style='display:none;position:absolute;left:" + String(inst.options.bordersize + 2) + "px;top:" + String(inst.options.bordersize + 2) + "px;'></div>" + "</div>" + "</div>");
                inst.$lightbox.css({
                    position: inst.options.supportCSSPositionFixed ? "fixed" : "absolute"
                });
                inst.$lightbox.appendTo("body");
                inst.$lightboxBox = $("#html5-lightbox-box", inst.$lightbox);
                inst.$elem = $("#html5-elem-box", inst.$lightbox);
                inst.$elemWrap = $("#html5-elem-wrap", inst.$lightbox);
                inst.$loading = $("#html5-loading", inst.$lightbox);
                inst.$error = $("#html5-error", inst.$lightbox);
                inst.$image = $("#html5-image", inst.$lightbox);
                inst.$next = $("#html5-next", inst.$lightbox);
                inst.$prev = $("#html5-prev", inst.$lightbox);
                var elemText = "<div id='html5-elem-data-box' style='display:none;'><div id='html5-text' style='display:block;overflow:hidden;'></div></div>";
                if (inst.options.titlepos == "over") inst.$elemWrap.append(elemText);
                else inst.$lightboxBox.append(elemText);
                inst.$elemData = $("#html5-elem-data-box",
                    inst.$lightbox);
                inst.$text = $("#html5-text", inst.$lightbox);
                if (inst.options.titlepos == "over") {
                    inst.$elemData.css({
                        position: "absolute",
                        padding: inst.options.bordersize + "px",
                        bottom: 0,
                        left: 0
                    });
                    inst.$text.css({
                        padding: inst.options.bordersize + "px",
                        "background-image": "url('" + inst.options.skinsfolder + inst.options.titlebgimage + "')"
                    })
                } else {
                    inst.$elemData.css({
                        position: "relative",
                        width: "100%",
                        margin: "0px auto",
                        height: inst.options.barheight + "px",
                        "background-color": inst.options.bgcolor
                    });
                    inst.$text.css({
                        "float": "left",
                        "margin-left": inst.options.bordersize + "px"
                    })
                } if (inst.options.closepos == "topright") inst.$elemWrap.append("<div id='html5-close' style='display:none;cursor:pointer;position:absolute;top:0;right:0;margin-top:-16px;margin-right:-16px;'><img src='" + inst.options.skinsfolder + inst.options.closeimage + "'></div>");
                else inst.$elemData.append("<div id='html5-close' style='display:block;cursor:pointer;float:right;margin-right:" + inst.options.bordersize + "px;'><img src='" + inst.options.skinsfolder + inst.options.closeimage +
                    "'></div>");
                inst.$close = $("#html5-close", inst.$lightbox);
                inst.$watermark = $("#html5-watermark", inst.$lightbox);
                if (inst.options.stamp) inst.$watermark.html("<a href='" + inst.options.freelink + "' style='text-decoration:none;'><div style='display:block;width:120px;height:20px;text-align:center;border-radius:5px;-moz-border-radius:5px;-webkit-border-radius:5px;filter:alpha(opacity=60);opacity:0.6;background-color:#333333;color:#ffffff;font:12px Armata,sans-serif,Arial;'><div style='line-height:20px;'>" + inst.options.freemark +
                    "</div></div></a>");
                else if (inst.options.watermark) {
                    var html = "<img src='" + inst.options.watermark + "' style='border:none;' />";
                    if (inst.options.watermarklink) html = "<a href='" + inst.options.watermarklink + "' target='_blank'>" + html + "</a>";
                    inst.$watermark.html(html)
                }
                $("#html5-lightbox-overlay", inst.$lightbox).click(inst.finish);
                inst.$close.click(inst.finish);
                inst.$next.click(function () {
                    inst.gotoSlide(-1)
                });
                inst.$prev.click(function () {
                    inst.gotoSlide(-2)
                });
                $(window).resize(function () {
                    if (!inst.options.isMobile) {
                        clearTimeout(inst.options.resizeTimeout);
                        inst.options.resizeTimeout = setTimeout(function () {
                            inst.resizeWindow()
                        }, 500)
                    }
                });
                $(window).scroll(function () {
                    inst.scrollBox()
                });
                $(window).bind("orientationchange", function (e) {
                    if (inst.options.isMobile) inst.resizeWindow()
                });
                inst.enableSwipe()
            };
            inst.calcNextPrevElem = function () {
                inst.options.nextElem = -1;
                inst.options.prevElem = -1;
                var j, curGroup = inst.elemArray[inst.options.curElem][ELEM_GROUP];
                if (curGroup != undefined && curGroup != null) {
                    for (j = inst.options.curElem + 1; j < inst.elemArray.length; j++)
                        if (inst.elemArray[j][ELEM_GROUP] ==
                            curGroup) {
                            inst.options.nextElem = j;
                            break
                        }
                    if (inst.options.nextElem < 0)
                        for (j = 0; j < inst.options.curElem; j++)
                            if (inst.elemArray[j][ELEM_GROUP] == curGroup) {
                                inst.options.nextElem = j;
                                break
                            }
                    if (inst.options.nextElem >= 0) {
                        for (j = inst.options.curElem - 1; j >= 0; j--)
                            if (inst.elemArray[j][ELEM_GROUP] == curGroup) {
                                inst.options.prevElem = j;
                                break
                            }
                        if (inst.options.prevElem < 0)
                            for (j = inst.elemArray.length - 1; j > inst.options.curElem; j--)
                                if (inst.elemArray[j][ELEM_GROUP] == curGroup) {
                                    inst.options.prevElem = j;
                                    break
                                }
                    }
                }
            };
            inst.clickHandler = function () {
                if (inst.elemArray.length <=
                    0) return true;
                var $this = $(this);
                inst.hideObjects();
                for (var i = 0; i < inst.elemArray.length; i++)
                    if (inst.elemArray[i][ELEM_HREF] == $this.attr("href")) break;
                if (i == inst.elemArray.length) return true;
                inst.options.curElem = i;
                inst.options.nextElem = -1;
                inst.options.prevElem = -1;
                inst.calcNextPrevElem();
                inst.$next.hide();
                inst.$prev.hide();
                inst.reset();
                inst.$lightbox.show();
                if (!inst.options.supportCSSPositionFixed) inst.$lightbox.css("top", $(window).scrollTop());
                var boxW = inst.options.loadingwidth + 2 * inst.options.bordersize;
                var boxH = inst.options.loadingheight + 2 * inst.options.bordersize;
                var winH = window.innerHeight ? window.innerHeight : $(window).height();
                var boxT = Math.round(winH / 2 - boxH / 2);
                if (inst.options.titlepos != "over") boxT -= Math.round(inst.options.barheight / 2);
                inst.$lightboxBox.css({
                    "margin-top": boxT,
                    "width": boxW,
                    "height": boxH
                });
                inst.$elemWrap.css({
                    "width": boxW,
                    "height": boxH
                });
                inst.loadCurElem();
                return false
            };
            inst.loadElem = function (elem) {
                inst.showing = true;
                inst.$elem.unbind("mouseenter").unbind("mouseleave").unbind("mousemove");
                inst.$loading.show();
                switch (elem[ELEM_TYPE]) {
                case 0:
                    var imgLoader = new Image;
                    $(imgLoader).load(function () {
                        inst.showImage(elem, imgLoader.width, imgLoader.height)
                    });
                    $(imgLoader).error(function () {
                        inst.showError()
                    });
                    imgLoader.src = elem[ELEM_HREF];
                    break;
                case 1:
                    inst.showSWF(elem);
                    break;
                case 2:
                case 8:
                    inst.showVideo(elem);
                    break;
                case 3:
                case 4:
                    inst.showYoutubeVimeo(elem);
                    break;
                case 5:
                    inst.showPDF(elem);
                    break;
                case 6:
                    inst.showMP3(elem);
                    break;
                case 7:
                    inst.showWeb(elem);
                    break
                }
            };
            inst.loadCurElem = function () {
                inst.loadElem(inst.elemArray[inst.options.curElem])
            };
            inst.showError = function () {
                inst.$loading.hide();
                inst.resizeLightbox(inst.options.errorwidth, inst.options.errorheight, true, function () {
                    inst.$error.show();
                    inst.$elem.fadeIn(inst.options.fadespeed, function () {
                        inst.showData()
                    })
                })
            };
            inst.calcTextWidth = function (objW) {
                return objW - 36
            };
            inst.showTitle = function (w, t) {
                if (inst.options.titlepos == "inside") {
                    inst.$elemData.css({
                        width: "100%"
                    });
                    inst.$text.css({
                        width: inst.calcTextWidth(w)
                    })
                } else inst.$elemData.css({
                    width: w
                });
                inst.$text.html(t)
            }, inst.showImage = function (elem,
                imgW, imgH) {
                var elemW, elemH;
                if (elem[ELEM_WIDTH]) elemW = elem[ELEM_WIDTH];
                else {
                    elemW = imgW;
                    elem[ELEM_WIDTH] = imgW
                } if (elem[ELEM_HEIGHT]) elemH = elem[ELEM_HEIGHT];
                else {
                    elemH = imgH;
                    elem[ELEM_HEIGHT] = imgH
                }
                var sizeObj = inst.calcElemSize({
                    w: elemW,
                    h: elemH
                });
                inst.resizeLightbox(sizeObj.w, sizeObj.h, true, function () {
                    inst.showTitle(sizeObj.w, elem[ELEM_TITLE]);
                    inst.$image.show().css({
                        width: sizeObj.w,
                        height: sizeObj.h
                    });
                    inst.$image.html("<img src='" + elem[ELEM_HREF] + "' width='" + sizeObj.w + "' height='" + sizeObj.h + "' />");
                    inst.$elem.fadeIn(inst.options.fadespeed,
                        function () {
                            inst.showData()
                        })
                })
            };
            inst.showSWF = function (elem) {
                var dataW = elem[ELEM_WIDTH] ? elem[ELEM_WIDTH] : 480;
                var dataH = elem[ELEM_HEIGHT] ? elem[ELEM_HEIGHT] : 270;
                var sizeObj = inst.calcElemSize({
                    w: dataW,
                    h: dataH
                });
                dataW = sizeObj.w;
                dataH = sizeObj.h;
                inst.resizeLightbox(dataW, dataH, true, function () {
                    inst.showTitle(sizeObj.w, elem[ELEM_TITLE]);
                    inst.$image.html("<div id='html5lightbox-swf' style='display:block;width:" + dataW + "px;height:" + dataH + "px;'></div>").show();
                    inst.embedFlash($("#html5lightbox-swf"), dataW, dataH,
                        elem[ELEM_HREF], "window", {
                            width: dataW,
                            height: dataH
                        });
                    inst.$elem.show();
                    inst.showData()
                })
            };
            inst.showVideo = function (elem) {
                var dataW = elem[ELEM_WIDTH] ? elem[ELEM_WIDTH] : 480;
                var dataH = elem[ELEM_HEIGHT] ? elem[ELEM_HEIGHT] : 270;
                var sizeObj = inst.calcElemSize({
                    w: dataW,
                    h: dataH
                });
                dataW = sizeObj.w;
                dataH = sizeObj.h;
                inst.resizeLightbox(dataW, dataH, true, function () {
                    inst.showTitle(sizeObj.w, elem[ELEM_TITLE]);
                    inst.$image.html("<div id='html5lightbox-video' style='display:block;width:" + dataW + "px;height:" + dataH + "px;'></div>").show();
                    var isHTML5 = false;
                    if (inst.options.isMobile) isHTML5 = true;
                    else if ((inst.options.html5player || !inst.options.flashInstalled) && inst.options.html5VideoSupported)
                        if (!inst.options.isFirefox && !inst.options.isOpera || (inst.options.isFirefox || inst.options.isOpera) && (elem[ELEM_HREF_OGG] || elem[ELEM_HREF_WEBM])) isHTML5 = true;
                    if (isHTML5) {
                        var videoSrc = elem[ELEM_HREF];
                        if (inst.options.isFirefox || inst.options.isOpera || !videoSrc) videoSrc = elem[ELEM_HREF_WEBM] ? elem[ELEM_HREF_WEBM] : elem[ELEM_HREF_OGG];
                        inst.embedHTML5Video($("#html5lightbox-video"),
                            dataW, dataH, videoSrc, inst.options.autoplay)
                    } else {
                        var videoFile = elem[ELEM_HREF];
                        if (videoFile.charAt(0) != "/" && videoFile.substring(0, 5) != "http:" && videoFile.substring(0, 6) != "https:") videoFile = inst.options.htmlfolder + videoFile;
                        inst.embedFlash($("#html5lightbox-video"), dataW, dataH, inst.options.jsfolder + "html5boxplayer.swf", "transparent", {
                            width: dataW,
                            height: dataH,
                            videofile: videoFile,
                            autoplay: inst.options.autoplay ? "1" : "0",
                            errorcss: ".html5box-error" + inst.options.errorcss,
                            id: 0
                        })
                    }
                    inst.$elem.show();
                    inst.showData()
                })
            };
            inst.prepareYoutubeHref = function (href) {
                var youtubeId = "";
                var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\??v?=?))([^#\&\?]*).*/;
                var match = href.match(regExp);
                if (match && match[7] && match[7].length == 11) youtubeId = match[7];
                return "http://www.youtube.com/embed/" + youtubeId
            };
            inst.showYoutubeVimeo = function (elem) {
                var dataW = elem[ELEM_WIDTH] ? elem[ELEM_WIDTH] : 480;
                var dataH = elem[ELEM_HEIGHT] ? elem[ELEM_HEIGHT] : 270;
                var sizeObj = inst.calcElemSize({
                    w: dataW,
                    h: dataH
                });
                dataW = sizeObj.w;
                dataH = sizeObj.h;
                inst.resizeLightbox(dataW,
                    dataH, true, function () {
                        inst.showTitle(sizeObj.w, elem[ELEM_TITLE]);
                        inst.$image.html("<div id='html5lightbox-video' style='display:block;width:" + dataW + "px;height:" + dataH + "px;'></div>").show();
                        var href = elem[ELEM_HREF];
                        if (elem[ELEM_TYPE] == 3) href = inst.prepareYoutubeHref(href);
                        if (inst.options.autoplay)
                            if (href.indexOf("?") < 0) href += "?autoplay=1";
                            else href += "&autoplay=1";
                        if (elem[ELEM_TYPE] == 3)
                            if (href.indexOf("?") < 0) href += "?wmode=transparent&rel=0";
                            else href += "&wmode=transparent&rel=0";
                        $("#html5lightbox-video").html("<iframe width='" +
                            dataW + "' height='" + dataH + "' src='" + href + "' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>");
                        inst.$elem.show();
                        inst.showData()
                    })
            };
            inst.showPDF = function (elem) {};
            inst.showMP3 = function (elem) {};
            inst.showWeb = function (elem) {
                var winH = window.innerHeight ? window.innerHeight : $(window).height();
                var dataW = elem[ELEM_WIDTH] ? elem[ELEM_WIDTH] : $(window).width();
                var dataH = elem[ELEM_HEIGHT] ? elem[ELEM_HEIGHT] : winH;
                var sizeObj = inst.calcElemSize({
                    w: dataW,
                    h: dataH
                });
                dataW = sizeObj.w;
                dataH =
                    sizeObj.h;
                inst.resizeLightbox(dataW, dataH, true, function () {
                    inst.showTitle(sizeObj.w, elem[ELEM_TITLE]);
                    inst.$image.html("<div id='html5lightbox-web' style='display:block;width:" + dataW + "px;height:" + dataH + "px;'></div>").show();
                    $("#html5lightbox-web").html("<iframe width='" + dataW + "' height='" + dataH + "' src='" + elem[ELEM_HREF] + "' frameborder='0'></iframe>");
                    inst.$elem.show();
                    inst.showData()
                })
            };
            inst.scrollBox = function () {
                if (!inst.options.supportCSSPositionFixed) inst.$lightbox.css("top", $(window).scrollTop())
            };
            inst.resizeWindow = function () {
                var winH = window.innerHeight ? window.innerHeight : $(window).height();
                var boxT = Math.round(winH / 2 - inst.$lightboxBox.height() / 2);
                if (inst.options.titlepos != "over") boxT -= Math.round(inst.options.barheight / 2);
                inst.$lightboxBox.animate({
                    "margin-top": boxT
                }, inst.options.resizespeed)
            };
            inst.calcElemSize = function (sizeObj) {
                var winH = window.innerHeight ? window.innerHeight : $(window).height();
                var h0 = winH - 2 * inst.options.bordersize - ($(window).width() > 600 ? 36 : 0);
                if (inst.options.titlepos != "over") h0 -=
                    inst.options.barheight;
                if (sizeObj.h > h0) {
                    sizeObj.w = Math.round(sizeObj.w * h0 / sizeObj.h);
                    sizeObj.h = h0
                }
                var w0 = $(window).width() - 2 * inst.options.bordersize;
                if (sizeObj.w > w0) {
                    sizeObj.h = Math.round(sizeObj.h * w0 / sizeObj.w);
                    sizeObj.w = w0
                }
                return sizeObj
            };
            inst.showData = function () {
                if (inst.$text.text().length > 0 || inst.options.closepos == "bottom") inst.$elemData.show();
                if (inst.options.closepos == "bottom" || inst.$text.text().length > 0 && inst.options.titlepos != "over") inst.$lightboxBox.css({
                    height: String(inst.$lightboxBox.height() +
                        inst.options.barheight) + "px"
                })
            };
            inst.resizeLightbox = function (elemW, elemH, bAnimate, onFinish) {
                var winH = window.innerHeight ? window.innerHeight : $(window).height();
                var speed = bAnimate ? inst.options.resizespeed : 0;
                var boxW = elemW + 2 * inst.options.bordersize;
                var boxH = elemH + 2 * inst.options.bordersize;
                var boxT = Math.round(winH / 2 - boxH / 2);
                if (inst.options.titlepos != "over") boxT -= Math.round(inst.options.barheight / 2);
                if (boxW == inst.$elemWrap.width() && boxH == inst.$elemWrap.height()) speed = 0;
                inst.$loading.hide();
                inst.$watermark.hide();
                inst.$elem.bind("mouseenter mousemove", function () {
                    if (inst.options.prevElem >= 0 || inst.options.nextElem >= 0) {
                        inst.$next.fadeIn();
                        inst.$prev.fadeIn()
                    }
                });
                inst.$elem.bind("mouseleave", function () {
                    inst.$next.fadeOut();
                    inst.$prev.fadeOut()
                });
                inst.$lightboxBox.css({
                    "margin-top": boxT
                });
                inst.$lightboxBox.css({
                    "width": boxW,
                    "height": boxH
                });
                inst.$elemWrap.animate({
                    width: boxW
                }, speed).animate({
                    height: boxH
                }, speed, function () {
                    inst.$loading.show();
                    inst.$watermark.show();
                    inst.$close.show();
                    onFinish()
                })
            };
            inst.reset = function () {
                if (inst.options.stamp) inst.$watermark.hide();
                inst.showing = false;
                inst.$image.empty();
                inst.$text.empty();
                inst.$error.hide();
                inst.$loading.hide();
                inst.$image.hide();
                inst.$elemData.hide();
                inst.$close.hide()
            };
            inst.finish = function () {
                inst.reset();
                inst.$lightbox.hide();
                inst.showObjects()
            };
            inst.pauseSlide = function () {};
            inst.playSlide = function () {};
            inst.gotoSlide = function (slide) {
                if (slide == -1) {
                    if (inst.options.nextElem < 0) return;
                    inst.options.curElem = inst.options.nextElem
                } else if (slide == -2) {
                    if (inst.options.prevElem < 0) return;
                    inst.options.curElem = inst.options.prevElem
                }
                inst.calcNextPrevElem();
                inst.reset();
                inst.loadCurElem()
            };
            inst.supportKeyboard = function () {
                $(document).keyup(function (e) {
                    if (!inst.showing) return;
                    if (inst.options.supportesckey && e.keyCode == 27) inst.finish();
                    else if (inst.options.supportarrowkeys)
                        if (e.keyCode == 39) inst.gotoSlide(-1);
                        else if (e.keyCode == 37) inst.gotoSlide(-2)
                })
            };
            inst.enableSwipe = function () {
                inst.$elem.touchSwipe({
                    preventWebBrowser: true,
                    swipeLeft: function () {
                        inst.gotoSlide(-1)
                    },
                    swipeRight: function () {
                        inst.gotoSlide(-2)
                    }
                })
            };
            inst.hideObjects = function () {
                $("select, embed, object").css({
                    "visibility": "hidden"
                })
            };
            inst.showObjects = function () {
                $("select, embed, object").css({
                    "visibility": "visible"
                })
            };
            inst.embedHTML5Video = function ($container, w, h, src, autoplay) {
                $container.html("<div style='position:absolute;display:block;width:" + w + "px;height:" + h + "px;'><video width=" + w + " height=" + h + (autoplay ? " autoplay" : "") + " controls='controls' src='" + src + "'></div>");
                if (inst.options.isAndroid) {
                    var $play = $("<div style='position:absolute;display:block;cursor:pointer;width:" + w + "px;height:" + h + 'px;background:url("' + inst.options.skinsfolder +
                        inst.options.playvideoimage + "\") no-repeat center center;'></div>").appendTo($container);
                    $play.unbind("click").click(function () {
                        $("video", $(this).parent())[0].play()
                    })
                }
            };
            inst.embedFlash = function ($container, w, h, src, wmode, flashVars) {
                if (inst.options.flashInstalled) {
                    var htmlOptions = {
                        pluginspage: "http://www.adobe.com/go/getflashplayer",
                        quality: "high",
                        allowFullScreen: "true",
                        allowScriptAccess: "always",
                        type: "application/x-shockwave-flash"
                    };
                    htmlOptions.width = w;
                    htmlOptions.height = h;
                    htmlOptions.src = src;
                    htmlOptions.flashVars =
                        $.param(flashVars);
                    htmlOptions.wmode = wmode;
                    var htmlString = "";
                    for (var key in htmlOptions) htmlString += key + "=" + htmlOptions[key] + " ";
                    $container.html("<embed " + htmlString + "/>")
                } else $container.html("<div class='html5lightbox-flash-error' style='display:block; position:relative;text-align:center; width:" + w + "px; left:0px; top:" + Math.round(h / 2 - 10) + "px;'><div class='html5-error'><div>The required Adobe Flash Player plugin is not installed</div><br /><div style='display:block;position:relative;text-align:center;width:112px;height:33px;margin:0px auto;'><a href='http://www.adobe.com/go/getflashplayer'><img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' width='112' height='33'></img></a></div></div>")
            };
            inst.checkType = function (href) {
                if (!href) return -1;
                if (href.match(/\.(jpg|gif|png|bmp|jpeg)(.*)?$/i)) return 0;
                if (href.match(/[^\.]\.(swf)\s*$/i)) return 1;
                if (href.match(/\.(flv|mp4|m4v|ogv|ogg|webm)(.*)?$/i)) return 2;
                if (href.match(/\:\/\/.*(youtube\.com)/i) || href.match(/\:\/\/.*(youtu\.be)/i)) return 3;
                if (href.match(/\:\/\/.*(vimeo\.com)/i)) return 4;
                if (href.match(/[^\.]\.(pdf)\s*$/i)) return 5;
                if (href.match(/[^\.]\.(mp3)\s*$/i)) return 6;
                if (href.match(/[^\.]\.(flv)\s*$/i)) return 8;
                return 7
            };
            inst.showLightbox =
                function (type, href, title, width, height, webm, ogg) {
                    inst.$next.hide();
                    inst.$prev.hide();
                    inst.reset();
                    inst.$lightbox.show();
                    if (!inst.options.supportCSSPositionFixed) inst.$lightbox.css("top", $(window).scrollTop());
                    var winH = window.innerHeight ? window.innerHeight : $(window).height();
                    var boxW = inst.options.loadingwidth + 2 * inst.options.bordersize;
                    var boxH = inst.options.loadingheight + 2 * inst.options.bordersize;
                    var boxT = Math.round(winH / 2 - boxH / 2);
                    if (inst.options.titlepos != "over") boxT -= Math.round(inst.options.barheight /
                        2);
                    inst.$lightboxBox.css({
                        "margin-top": boxT,
                        "width": boxW,
                        "height": boxH
                    });
                    inst.$elemWrap.css({
                        "width": boxW,
                        "height": boxH
                    });
                    inst.loadElem(new Array(type, href, title, null, width, height, webm, ogg))
            };
            inst.addItem = function (href, title, group, width, height, webm, ogg) {
                type = inst.checkType(href);
                inst.elemArray.push(new Array(type, href, title, group, width, height, webm, ogg))
            };
            inst.showItem = function (href) {
                if (inst.elemArray.length <= 0) return true;
                inst.hideObjects();
                for (var i = 0; i < inst.elemArray.length; i++)
                    if (inst.elemArray[i][ELEM_HREF] ==
                        href) break;
                if (i == inst.elemArray.length) return true;
                inst.options.curElem = i;
                inst.options.nextElem = -1;
                inst.options.prevElem = -1;
                inst.calcNextPrevElem();
                inst.$next.hide();
                inst.$prev.hide();
                inst.reset();
                inst.$lightbox.show();
                if (!inst.options.supportCSSPositionFixed) inst.$lightbox.css("top", $(window).scrollTop());
                var winH = window.innerHeight ? window.innerHeight : $(window).height();
                var boxW = inst.options.loadingwidth + 2 * inst.options.bordersize;
                var boxH = inst.options.loadingheight + 2 * inst.options.bordersize;
                var boxT =
                    Math.round(winH / 2 - boxH / 2);
                if (inst.options.titlepos != "over") boxT -= Math.round(inst.options.barheight / 2);
                inst.$lightboxBox.css({
                    "margin-top": boxT,
                    "width": boxW,
                    "height": boxH
                });
                inst.$elemWrap.css({
                    "width": boxW,
                    "height": boxH
                });
                inst.loadCurElem();
                return false
            };
            inst.init();
            return inst.unbind("click").click(inst.clickHandler)
        }
    })(jQuery);
    (function ($) {
        $.fn.touchSwipe = function (options) {
            var defaults = {
                preventWebBrowser: false,
                swipeLeft: null,
                swipeRight: null,
                swipeTop: null,
                swipeBottom: null
            };
            if (options) $.extend(defaults,
                options);
            return this.each(function () {
                var startX = -1,
                    startY = -1;
                var curX = -1,
                    curY = -1;

                function touchStart(event) {
                    var e = event.originalEvent;
                    if (e.targetTouches.length >= 1) {
                        startX = e.targetTouches[0].pageX;
                        startY = e.targetTouches[0].pageY
                    } else touchCancel(event)
                }

                function touchMove(event) {
                    if (defaults.preventWebBrowser) event.preventDefault();
                    var e = event.originalEvent;
                    if (e.targetTouches.length >= 1) {
                        curX = e.targetTouches[0].pageX;
                        curY = e.targetTouches[0].pageY
                    } else touchCancel(event)
                }

                function touchEnd(event) {
                    if (curX >
                        0 || curY > 0) {
                        triggerHandler();
                        touchCancel(event)
                    } else touchCancel(event)
                }

                function touchCancel(event) {
                    startX = -1;
                    startY = -1;
                    curX = -1;
                    curY = -1
                }

                function triggerHandler() {
                    if (curX > startX) {
                        if (defaults.swipeRight) defaults.swipeRight.call()
                    } else if (defaults.swipeLeft) defaults.swipeLeft.call();
                    if (curY > startY) {
                        if (defaults.swipeBottom) defaults.swipeBottom.call()
                    } else if (defaults.swipeTop) defaults.swipeTop.call()
                }
                try {
                    $(this).bind("touchstart", touchStart);
                    $(this).bind("touchmove", touchMove);
                    $(this).bind("touchend",
                        touchEnd);
                    $(this).bind("touchcancel", touchCancel)
                } catch (e) {}
            })
        }
    })(jQuery);
    jQuery(document).ready(function () {
        if (typeof html5Lightbox === "undefined") html5Lightbox = jQuery(".html5lightbox").html5lightbox()
    })
};
