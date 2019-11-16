(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.Neo4jd3 = f()}})(function(){var define,module,exports;return (function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(_dereq_,module,exports){
'use strict';

var neo4jd3 = _dereq_('./scripts/neo4jd3');

module.exports = neo4jd3;

},{"./scripts/neo4jd3":4}],2:[function(_dereq_,module,exports){
function fontAwesomeIcons() {
  return {
    "glass": "f000",
    "music": "f001",
    "search": "f002",
    "envelope-o": "f003",
    "heart": "f004",
    "star": "f005",
    "star-o": "f006",
    "user": "f007",
    "film": "f008",
    "th-large": "f009",
    "th": "f00a",
    "th-list": "f00b",
    "check": "f00c",
    "remove,close,times": "f00d",
    "search-plus": "f00e",
    "search-minus": "f010",
    "power-off": "f011",
    "signal": "f012",
    "gear,cog": "f013",
    "trash-o": "f014",
    "home": "f015",
    "file-o": "f016",
    "clock-o": "f017",
    "road": "f018",
    "download": "f019",
    "arrow-circle-o-down": "f01a",
    "arrow-circle-o-up": "f01b",
    "inbox": "f01c",
    "play-circle-o": "f01d",
    "rotate-right,repeat": "f01e",
    "refresh": "f021",
    "list-alt": "f022",
    "lock": "f023",
    "flag": "f024",
    "headphones": "f025",
    "volume-off": "f026",
    "volume-down": "f027",
    "volume-up": "f028",
    "qrcode": "f029",
    "barcode": "f02a",
    "tag": "f02b",
    "tags": "f02c",
    "book": "f02d",
    "bookmark": "f02e",
    "print": "f02f",
    "camera": "f030",
    "font": "f031",
    "bold": "f032",
    "italic": "f033",
    "text-height": "f034",
    "text-width": "f035",
    "align-left": "f036",
    "align-center": "f037",
    "align-right": "f038",
    "align-justify": "f039",
    "list": "f03a",
    "dedent,outdent": "f03b",
    "indent": "f03c",
    "video-camera": "f03d",
    "photo,image,picture-o": "f03e",
    "pencil": "f040",
    "map-marker": "f041",
    "adjust": "f042",
    "tint": "f043",
    "edit,pencil-square-o": "f044",
    "share-square-o": "f045",
    "check-square-o": "f046",
    "arrows": "f047",
    "step-backward": "f048",
    "fast-backward": "f049",
    "backward": "f04a",
    "play": "f04b",
    "pause": "f04c",
    "stop": "f04d",
    "forward": "f04e",
    "fast-forward": "f050",
    "step-forward": "f051",
    "eject": "f052",
    "chevron-left": "f053",
    "chevron-right": "f054",
    "plus-circle": "f055",
    "minus-circle": "f056",
    "times-circle": "f057",
    "check-circle": "f058",
    "question-circle": "f059",
    "info-circle": "f05a",
    "crosshairs": "f05b",
    "times-circle-o": "f05c",
    "check-circle-o": "f05d",
    "ban": "f05e",
    "arrow-left": "f060",
    "arrow-right": "f061",
    "arrow-up": "f062",
    "arrow-down": "f063",
    "mail-forward,share": "f064",
    "expand": "f065",
    "compress": "f066",
    "plus": "f067",
    "minus": "f068",
    "asterisk": "f069",
    "exclamation-circle": "f06a",
    "gift": "f06b",
    "leaf": "f06c",
    "fire": "f06d",
    "eye": "f06e",
    "eye-slash": "f070",
    "warning,exclamation-triangle": "f071",
    "plane": "f072",
    "calendar": "f073",
    "random": "f074",
    "comment": "f075",
    "magnet": "f076",
    "chevron-up": "f077",
    "chevron-down": "f078",
    "retweet": "f079",
    "shopping-cart": "f07a",
    "folder": "f07b",
    "folder-open": "f07c",
    "arrows-v": "f07d",
    "arrows-h": "f07e",
    "bar-chart-o,bar-chart": "f080",
    "twitter-square": "f081",
    "facebook-square": "f082",
    "camera-retro": "f083",
    "key": "f084",
    "gears,cogs": "f085",
    "comments": "f086",
    "thumbs-o-up": "f087",
    "thumbs-o-down": "f088",
    "star-half": "f089",
    "heart-o": "f08a",
    "sign-out": "f08b",
    "linkedin-square": "f08c",
    "thumb-tack": "f08d",
    "external-link": "f08e",
    "sign-in": "f090",
    "trophy": "f091",
    "github-square": "f092",
    "upload": "f093",
    "lemon-o": "f094",
    "phone": "f095",
    "square-o": "f096",
    "bookmark-o": "f097",
    "phone-square": "f098",
    "twitter": "f099",
    "facebook-f,facebook": "f09a",
    "github": "f09b",
    "unlock": "f09c",
    "credit-card": "f09d",
    "feed,rss": "f09e",
    "hdd-o": "f0a0",
    "bullhorn": "f0a1",
    "bell": "f0f3",
    "certificate": "f0a3",
    "hand-o-right": "f0a4",
    "hand-o-left": "f0a5",
    "hand-o-up": "f0a6",
    "hand-o-down": "f0a7",
    "arrow-circle-left": "f0a8",
    "arrow-circle-right": "f0a9",
    "arrow-circle-up": "f0aa",
    "arrow-circle-down": "f0ab",
    "globe": "f0ac",
    "wrench": "f0ad",
    "tasks": "f0ae",
    "filter": "f0b0",
    "briefcase": "f0b1",
    "arrows-alt": "f0b2",
    "group,users": "f0c0",
    "chain,link": "f0c1",
    "cloud": "f0c2",
    "flask": "f0c3",
    "cut,scissors": "f0c4",
    "copy,files-o": "f0c5",
    "paperclip": "f0c6",
    "save,floppy-o": "f0c7",
    "square": "f0c8",
    "navicon,reorder,bars": "f0c9",
    "list-ul": "f0ca",
    "list-ol": "f0cb",
    "strikethrough": "f0cc",
    "underline": "f0cd",
    "table": "f0ce",
    "magic": "f0d0",
    "truck": "f0d1",
    "pinterest": "f0d2",
    "pinterest-square": "f0d3",
    "google-plus-square": "f0d4",
    "google-plus": "f0d5",
    "money": "f0d6",
    "caret-down": "f0d7",
    "caret-up": "f0d8",
    "caret-left": "f0d9",
    "caret-right": "f0da",
    "columns": "f0db",
    "unsorted,sort": "f0dc",
    "sort-down,sort-desc": "f0dd",
    "sort-up,sort-asc": "f0de",
    "envelope": "f0e0",
    "linkedin": "f0e1",
    "rotate-left,undo": "f0e2",
    "legal,gavel": "f0e3",
    "dashboard,tachometer": "f0e4",
    "comment-o": "f0e5",
    "comments-o": "f0e6",
    "flash,bolt": "f0e7",
    "sitemap": "f0e8",
    "umbrella": "f0e9",
    "paste,clipboard": "f0ea",
    "lightbulb-o": "f0eb",
    "exchange": "f0ec",
    "cloud-download": "f0ed",
    "cloud-upload": "f0ee",
    "user-md": "f0f0",
    "stethoscope": "f0f1",
    "suitcase": "f0f2",
    "bell-o": "f0a2",
    "coffee": "f0f4",
    "cutlery": "f0f5",
    "file-text-o": "f0f6",
    "building-o": "f0f7",
    "hospital-o": "f0f8",
    "ambulance": "f0f9",
    "medkit": "f0fa",
    "fighter-jet": "f0fb",
    "beer": "f0fc",
    "h-square": "f0fd",
    "plus-square": "f0fe",
    "angle-double-left": "f100",
    "angle-double-right": "f101",
    "angle-double-up": "f102",
    "angle-double-down": "f103",
    "angle-left": "f104",
    "angle-right": "f105",
    "angle-up": "f106",
    "angle-down": "f107",
    "desktop": "f108",
    "laptop": "f109",
    "tablet": "f10a",
    "mobile-phone,mobile": "f10b",
    "circle-o": "f10c",
    "quote-left": "f10d",
    "quote-right": "f10e",
    "spinner": "f110",
    "circle": "f111",
    "mail-reply,reply": "f112",
    "github-alt": "f113",
    "folder-o": "f114",
    "folder-open-o": "f115",
    "smile-o": "f118",
    "frown-o": "f119",
    "meh-o": "f11a",
    "gamepad": "f11b",
    "keyboard-o": "f11c",
    "flag-o": "f11d",
    "flag-checkered": "f11e",
    "terminal": "f120",
    "code": "f121",
    "mail-reply-all,reply-all": "f122",
    "star-half-empty,star-half-full,star-half-o": "f123",
    "location-arrow": "f124",
    "crop": "f125",
    "code-fork": "f126",
    "unlink,chain-broken": "f127",
    "question": "f128",
    "info": "f129",
    "exclamation": "f12a",
    "superscript": "f12b",
    "subscript": "f12c",
    "eraser": "f12d",
    "puzzle-piece": "f12e",
    "microphone": "f130",
    "microphone-slash": "f131",
    "shield": "f132",
    "calendar-o": "f133",
    "fire-extinguisher": "f134",
    "rocket": "f135",
    "maxcdn": "f136",
    "chevron-circle-left": "f137",
    "chevron-circle-right": "f138",
    "chevron-circle-up": "f139",
    "chevron-circle-down": "f13a",
    "html5": "f13b",
    "css3": "f13c",
    "anchor": "f13d",
    "unlock-alt": "f13e",
    "bullseye": "f140",
    "ellipsis-h": "f141",
    "ellipsis-v": "f142",
    "rss-square": "f143",
    "play-circle": "f144",
    "ticket": "f145",
    "minus-square": "f146",
    "minus-square-o": "f147",
    "level-up": "f148",
    "level-down": "f149",
    "check-square": "f14a",
    "pencil-square": "f14b",
    "external-link-square": "f14c",
    "share-square": "f14d",
    "compass": "f14e",
    "toggle-down,caret-square-o-down": "f150",
    "toggle-up,caret-square-o-up": "f151",
    "toggle-right,caret-square-o-right": "f152",
    "euro,eur": "f153",
    "gbp": "f154",
    "dollar,usd": "f155",
    "rupee,inr": "f156",
    "cny,rmb,yen,jpy": "f157",
    "ruble,rouble,rub": "f158",
    "won,krw": "f159",
    "bitcoin,btc": "f15a",
    "file": "f15b",
    "file-text": "f15c",
    "sort-alpha-asc": "f15d",
    "sort-alpha-desc": "f15e",
    "sort-amount-asc": "f160",
    "sort-amount-desc": "f161",
    "sort-numeric-asc": "f162",
    "sort-numeric-desc": "f163",
    "thumbs-up": "f164",
    "thumbs-down": "f165",
    "youtube-square": "f166",
    "youtube": "f167",
    "xing": "f168",
    "xing-square": "f169",
    "youtube-play": "f16a",
    "dropbox": "f16b",
    "stack-overflow": "f16c",
    "instagram": "f16d",
    "flickr": "f16e",
    "adn": "f170",
    "bitbucket": "f171",
    "bitbucket-square": "f172",
    "tumblr": "f173",
    "tumblr-square": "f174",
    "long-arrow-down": "f175",
    "long-arrow-up": "f176",
    "long-arrow-left": "f177",
    "long-arrow-right": "f178",
    "apple": "f179",
    "windows": "f17a",
    "android": "f17b",
    "linux": "f17c",
    "dribbble": "f17d",
    "skype": "f17e",
    "foursquare": "f180",
    "trello": "f181",
    "female": "f182",
    "male": "f183",
    "gittip,gratipay": "f184",
    "sun-o": "f185",
    "moon-o": "f186",
    "archive": "f187",
    "bug": "f188",
    "vk": "f189",
    "weibo": "f18a",
    "renren": "f18b",
    "pagelines": "f18c",
    "stack-exchange": "f18d",
    "arrow-circle-o-right": "f18e",
    "arrow-circle-o-left": "f190",
    "toggle-left,caret-square-o-left": "f191",
    "dot-circle-o": "f192",
    "wheelchair": "f193",
    "vimeo-square": "f194",
    "turkish-lira,try": "f195",
    "plus-square-o": "f196",
    "space-shuttle": "f197",
    "slack": "f198",
    "envelope-square": "f199",
    "wordpress": "f19a",
    "openid": "f19b",
    "institution,bank,university": "f19c",
    "mortar-board,graduation-cap": "f19d",
    "yahoo": "f19e",
    "google": "f1a0",
    "reddit": "f1a1",
    "reddit-square": "f1a2",
    "stumbleupon-circle": "f1a3",
    "stumbleupon": "f1a4",
    "delicious": "f1a5",
    "digg": "f1a6",
    "pied-piper-pp": "f1a7",
    "pied-piper-alt": "f1a8",
    "drupal": "f1a9",
    "joomla": "f1aa",
    "language": "f1ab",
    "fax": "f1ac",
    "building": "f1ad",
    "child": "f1ae",
    "paw": "f1b0",
    "spoon": "f1b1",
    "cube": "f1b2",
    "cubes": "f1b3",
    "behance": "f1b4",
    "behance-square": "f1b5",
    "steam": "f1b6",
    "steam-square": "f1b7",
    "recycle": "f1b8",
    "automobile,car": "f1b9",
    "cab,taxi": "f1ba",
    "tree": "f1bb",
    "spotify": "f1bc",
    "deviantart": "f1bd",
    "soundcloud": "f1be",
    "database": "f1c0",
    "file-pdf-o": "f1c1",
    "file-word-o": "f1c2",
    "file-excel-o": "f1c3",
    "file-powerpoint-o": "f1c4",
    "file-photo-o,file-picture-o,file-image-o": "f1c5",
    "file-zip-o,file-archive-o": "f1c6",
    "file-sound-o,file-audio-o": "f1c7",
    "file-movie-o,file-video-o": "f1c8",
    "file-code-o": "f1c9",
    "vine": "f1ca",
    "codepen": "f1cb",
    "jsfiddle": "f1cc",
    "life-bouy,life-buoy,life-saver,support,life-ring": "f1cd",
    "circle-o-notch": "f1ce",
    "ra,resistance,rebel": "f1d0",
    "ge,empire": "f1d1",
    "git-square": "f1d2",
    "git": "f1d3",
    "y-combinator-square,yc-square,hacker-news": "f1d4",
    "tencent-weibo": "f1d5",
    "qq": "f1d6",
    "wechat,weixin": "f1d7",
    "send,paper-plane": "f1d8",
    "send-o,paper-plane-o": "f1d9",
    "history": "f1da",
    "circle-thin": "f1db",
    "header": "f1dc",
    "paragraph": "f1dd",
    "sliders": "f1de",
    "share-alt": "f1e0",
    "share-alt-square": "f1e1",
    "bomb": "f1e2",
    "soccer-ball-o,futbol-o": "f1e3",
    "tty": "f1e4",
    "binoculars": "f1e5",
    "plug": "f1e6",
    "slideshare": "f1e7",
    "twitch": "f1e8",
    "yelp": "f1e9",
    "newspaper-o": "f1ea",
    "wifi": "f1eb",
    "calculator": "f1ec",
    "paypal": "f1ed",
    "google-wallet": "f1ee",
    "cc-visa": "f1f0",
    "cc-mastercard": "f1f1",
    "cc-discover": "f1f2",
    "cc-amex": "f1f3",
    "cc-paypal": "f1f4",
    "cc-stripe": "f1f5",
    "bell-slash": "f1f6",
    "bell-slash-o": "f1f7",
    "trash": "f1f8",
    "copyright": "f1f9",
    "at": "f1fa",
    "eyedropper": "f1fb",
    "paint-brush": "f1fc",
    "birthday-cake": "f1fd",
    "area-chart": "f1fe",
    "pie-chart": "f200",
    "line-chart": "f201",
    "lastfm": "f202",
    "lastfm-square": "f203",
    "toggle-off": "f204",
    "toggle-on": "f205",
    "bicycle": "f206",
    "bus": "f207",
    "ioxhost": "f208",
    "angellist": "f209",
    "cc": "f20a",
    "shekel,sheqel,ils": "f20b",
    "meanpath": "f20c",
    "buysellads": "f20d",
    "connectdevelop": "f20e",
    "dashcube": "f210",
    "forumbee": "f211",
    "leanpub": "f212",
    "sellsy": "f213",
    "shirtsinbulk": "f214",
    "simplybuilt": "f215",
    "skyatlas": "f216",
    "cart-plus": "f217",
    "cart-arrow-down": "f218",
    "diamond": "f219",
    "ship": "f21a",
    "user-secret": "f21b",
    "motorcycle": "f21c",
    "street-view": "f21d",
    "heartbeat": "f21e",
    "venus": "f221",
    "mars": "f222",
    "mercury": "f223",
    "intersex,transgender": "f224",
    "transgender-alt": "f225",
    "venus-double": "f226",
    "mars-double": "f227",
    "venus-mars": "f228",
    "mars-stroke": "f229",
    "mars-stroke-v": "f22a",
    "mars-stroke-h": "f22b",
    "neuter": "f22c",
    "genderless": "f22d",
    "facebook-official": "f230",
    "pinterest-p": "f231",
    "whatsapp": "f232",
    "server": "f233",
    "user-plus": "f234",
    "user-times": "f235",
    "hotel,bed": "f236",
    "viacoin": "f237",
    "train": "f238",
    "subway": "f239",
    "medium": "f23a",
    "yc,y-combinator": "f23b",
    "optin-monster": "f23c",
    "opencart": "f23d",
    "expeditedssl": "f23e",
    "battery-4,battery-full": "f240",
    "battery-3,battery-three-quarters": "f241",
    "battery-2,battery-half": "f242",
    "battery-1,battery-quarter": "f243",
    "battery-0,battery-empty": "f244",
    "mouse-pointer": "f245",
    "i-cursor": "f246",
    "object-group": "f247",
    "object-ungroup": "f248",
    "sticky-note": "f249",
    "sticky-note-o": "f24a",
    "cc-jcb": "f24b",
    "cc-diners-club": "f24c",
    "clone": "f24d",
    "balance-scale": "f24e",
    "hourglass-o": "f250",
    "hourglass-1,hourglass-start": "f251",
    "hourglass-2,hourglass-half": "f252",
    "hourglass-3,hourglass-end": "f253",
    "hourglass": "f254",
    "hand-grab-o,hand-rock-o": "f255",
    "hand-stop-o,hand-paper-o": "f256",
    "hand-scissors-o": "f257",
    "hand-lizard-o": "f258",
    "hand-spock-o": "f259",
    "hand-pointer-o": "f25a",
    "hand-peace-o": "f25b",
    "trademark": "f25c",
    "registered": "f25d",
    "creative-commons": "f25e",
    "gg": "f260",
    "gg-circle": "f261",
    "tripadvisor": "f262",
    "odnoklassniki": "f263",
    "odnoklassniki-square": "f264",
    "get-pocket": "f265",
    "wikipedia-w": "f266",
    "safari": "f267",
    "chrome": "f268",
    "firefox": "f269",
    "opera": "f26a",
    "internet-explorer": "f26b",
    "tv,television": "f26c",
    "contao": "f26d",
    "500px": "f26e",
    "amazon": "f270",
    "calendar-plus-o": "f271",
    "calendar-minus-o": "f272",
    "calendar-times-o": "f273",
    "calendar-check-o": "f274",
    "industry": "f275",
    "map-pin": "f276",
    "map-signs": "f277",
    "map-o": "f278",
    "map": "f279",
    "commenting": "f27a",
    "commenting-o": "f27b",
    "houzz": "f27c",
    "vimeo": "f27d",
    "black-tie": "f27e",
    "fonticons": "f280",
    "reddit-alien": "f281",
    "edge": "f282",
    "credit-card-alt": "f283",
    "codiepie": "f284",
    "modx": "f285",
    "fort-awesome": "f286",
    "usb": "f287",
    "product-hunt": "f288",
    "mixcloud": "f289",
    "scribd": "f28a",
    "pause-circle": "f28b",
    "pause-circle-o": "f28c",
    "stop-circle": "f28d",
    "stop-circle-o": "f28e",
    "shopping-bag": "f290",
    "shopping-basket": "f291",
    "hashtag": "f292",
    "bluetooth": "f293",
    "bluetooth-b": "f294",
    "percent": "f295",
    "gitlab": "f296",
    "wpbeginner": "f297",
    "wpforms": "f298",
    "envira": "f299",
    "universal-access": "f29a",
    "wheelchair-alt": "f29b",
    "question-circle-o": "f29c",
    "blind": "f29d",
    "audio-description": "f29e",
    "volume-control-phone": "f2a0",
    "braille": "f2a1",
    "assistive-listening-systems": "f2a2",
    "asl-interpreting,american-sign-language-interpreting": "f2a3",
    "deafness,hard-of-hearing,deaf": "f2a4",
    "glide": "f2a5",
    "glide-g": "f2a6",
    "signing,sign-language": "f2a7",
    "low-vision": "f2a8",
    "viadeo": "f2a9",
    "viadeo-square": "f2aa",
    "snapchat": "f2ab",
    "snapchat-ghost": "f2ac",
    "snapchat-square": "f2ad",
    "pied-piper": "f2ae",
    "first-order": "f2b0",
    "yoast": "f2b1",
    "themeisle": "f2b2",
    "google-plus-circle,google-plus-official": "f2b3",
    "fa,font-awesome": "f2b4"
  };
}

var FontAwesome = {
  fontAwesomeIcons: fontAwesomeIcons
};

module.exports = FontAwesome;

},{}],3:[function(_dereq_,module,exports){

function appendInfoPanel(container) {
    return container.append('div')
      .attr('class', 'neo4jd3-info');
  }
  
  function appendInfoElement(cls, isNode, property, value) {
    var elem = info.append('a');
    
    elem.attr('href', '#')
      .attr('class', cls)
      .html('<strong>' + property + '</strong>' + (value ? (': ' + value) : ''));
    
    if (!value) {
      elem.style('background-color', function(d) {
        return options.nodeOutlineFillColor ? options.nodeOutlineFillColor : (isNode ? class2color(property) : defaultColor());
      })
        .style('border-color', function(d) {
          return options.nodeOutlineFillColor ? class2darkenColor(options.nodeOutlineFillColor) : (isNode ? class2darkenColor(property) : defaultDarkenColor());
        })
        .style('color', function(d) {
          return options.nodeOutlineFillColor ? class2darkenColor(options.nodeOutlineFillColor) : '#fff';
        });
    }
  }
  
  function appendInfoElementClass(cls, node) {
    appendInfoElement(cls, true, node);
  }
  
  function appendInfoElementProperty(cls, property, value) {
    appendInfoElement(cls, false, property, value);
  }
  
  function appendInfoElementRelationship(cls, relationship) {
    appendInfoElement(cls, false, relationship);
  }

  function updateInfo(d) {
    clearInfo();
    
    if (d.labels) {
      appendInfoElementClass('class', d.labels[0]);
    } else {
      appendInfoElementRelationship('class', d.type);
    }
    
    appendInfoElementProperty('property', '&lt;id&gt;', d.id);
    
    Object.keys(d.properties).forEach(function(property) {
      appendInfoElementProperty('property', property, JSON.stringify(d.properties[property]));
    });
  }

  var InfoBar = {

      appendInfoPanel: appendInfoPanel,
      appendInfoElement: appendInfoElement,
      appendInfoElementClass: appendInfoElementClass,
      appendInfoElementProperty: appendInfoElementProperty,
      appendInfoElementRelationship: appendInfoElementRelationship,
      updateInfo: updateInfo
  }

module.exports = InfoBar;

},{}],4:[function(_dereq_,module,exports){
/* global d3, document */
/* jshint latedef:nofunc */
'use strict';
var InfoPanel = _dereq_("./infobar.js");
var FontAwesome = _dereq_("./fontawesome.js");

function Neo4jD3(_selector, _options) {
  var container, graph, info, node, nodes, relationship, relationshipOutline, relationshipOverlay, relationshipText, relationships, selector, simulation, svg, svgNodes, svgRelationships, svgScale, svgTranslate,
    classes2colors = {},
    justLoaded = false,
    numClasses = 0,
    options = {
      arrowSize: 4,
      colors: colors(),
      highlight: undefined,
      iconMap: FontAwesome.fontAwesomeIcons(),
      icons: undefined,
      imageMap: {},
      images: undefined,
      infoPanel: true,
      minCollision: undefined,
      neo4jData: undefined,
      neo4jDataUrl: undefined,
      nodeOutlineFillColor: undefined,
      nodeRadius: 25,
      relationshipColor: '#a5abb6',
      zoomFit: false
    },
    VERSION = '0.0.2';

  function appendGraph(container) {
    svg = container.append('svg')
      .attr('width', '100%')
      .attr('height', '100%')
      .attr('class', 'neo4jd3-graph')
      .call(d3.zoom().on('zoom', function() {
        var scale = d3.event.transform.k,
          translate = [d3.event.transform.x, d3.event.transform.y];

        if (svgTranslate) {
          translate[0] += svgTranslate[0];
          translate[1] += svgTranslate[1];
        }

        if (svgScale) {
          scale *= svgScale;
        }

        svg.attr('transform', 'translate(' + translate[0] + ', ' + translate[1] + ') scale(' + scale + ')');
      }))
      .on('dblclick.zoom', null)
      .append('g')
      .attr('width', '100%')
      .attr('height', '100%');

    svgRelationships = svg.append('g')
      .attr('class', 'relationships');

    svgNodes = svg.append('g')
      .attr('class', 'nodes');
  }

  function appendImageToNode(node) {
    return node.append('image')
      .attr('height', function(d) {
        return icon(d) ? '24px': '30px';
      })
      .attr('x', function(d) {
        return icon(d) ? '5px': '-15px';
      })
      .attr('xlink:href', function(d) {
        return image(d);
      })
      .attr('y', function(d) {
        return icon(d) ? '5px': '-16px';
      })
      .attr('width', function(d) {
        return icon(d) ? '24px': '30px';
      });
  }

  function appendNode() {
    return node.enter()
      .append('g')
      .attr('class', function(d) {
        var highlight, i,
          classes = 'node',
          label = d.label;

        if (icon(d)) {
          classes += ' node-icon';
        }

        if (image(d)) {
          classes += ' node-image';
        }

        if (options.highlight) {
          for (i = 0; i < options.highlight.length; i++) {
            highlight = options.highlight[i];

            if (d.label === highlight.class && d.properties[highlight.property] === highlight.value) {
              classes += ' node-highlighted';
              break;
            }
          }
        }

        return classes;
      })
      .on('click', function(d) {
        d.fx = d.fy = null;

        if (typeof options.onNodeClick === 'function') {
          options.onNodeClick(d);
        }
      })
      .on('dblclick', function(d) {
        stickNode(d);

        if (typeof options.onNodeDoubleClick === 'function') {
          options.onNodeDoubleClick(d);
        }
      })
      .on('mouseenter', function(d) {
        if (info) {
          InfoPanel.updateInfo(d);
        }

        if (typeof options.onNodeMouseEnter === 'function') {
          options.onNodeMouseEnter(d);
        }
      })
      .on('mouseleave', function(d) {
        if (info) {
          InfoPanel.clearInfo(d);
        }

        if (typeof options.onNodeMouseLeave === 'function') {
          options.onNodeMouseLeave(d);
        }
      })
      .call(d3.drag()
        .on('start', dragStarted)
        .on('drag', dragged)
        .on('end', dragEnded));
  }

  function appendNodeToGraph() {
    var n = appendNode();

    appendRingToNode(n);
    appendOutlineToNode(n);

    if (options.icons) {
      appendTextToNode(n);
    }

    if (options.images) {
      appendImageToNode(n);
    }

    return n;
  }

  function appendOutlineToNode(node) {
    return node.append('circle')
      .attr('class', 'outline')
      .attr('r', options.nodeRadius)
      .style('fill', function(d) {
        return options.nodeOutlineFillColor ? options.nodeOutlineFillColor : class2color(d.label);
      })
      .style('stroke', function(d) {
        return options.nodeOutlineFillColor ? class2darkenColor(options.nodeOutlineFillColor) : class2darkenColor(d.label);
      })
      .append('title').text(function(d) {
        return toString(d);
      });
  }

  function appendRingToNode(node) {
    return node.append('circle')
      .attr('class', 'ring')
      .attr('r', options.nodeRadius * 1.16)
      .append('title').text(function(d) {

        return toString(d);
      });
  }

  function appendTextToNode(node) {
    return node.append('text')
      .attr('class', function(d) {
        return 'text' + (icon(d) ? ' icon' : '');
      })
      .attr('fill', '#ffffff')
      .attr('font-size', function(d) {
        return icon(d) ? (options.nodeRadius + 'px') : '10px';
      })
      .attr('pointer-events', 'none')
      .attr('text-anchor', 'middle')
      .attr('y', function(d) {
        return icon(d) ? (parseInt(Math.round(options.nodeRadius * 0.32)) + 'px') : '4px';
      })
      .html(function(d) {
        var _icon = icon(d);
        return _icon ? '&#x' + _icon : d.label;
      });
  }

  function appendRelationship() {
    return relationship.enter()
      .append('g')
      .attr('class', 'relationship')
      .on('dblclick', function(d) {
        if (typeof options.onRelationshipDoubleClick === 'function') {
          options.onRelationshipDoubleClick(d);
        }
      })
      .on('mouseenter', function(d) {
        if (info) {
          InfoPanel.updateInfo(d);
        }
      });
  }

  function appendOutlineToRelationship(r) {
    return r.append('path')
      .attr('class', 'outline')
      .attr('fill', '#a5abb6')
      .attr('stroke', 'none');
  }

  function appendOverlayToRelationship(r) {
    return r.append('path')
      .attr('class', 'overlay');
  }

  function appendTextToRelationship(r) {
    return r.append('text')
      .attr('class', 'text')
      .attr('fill', '#000000')
      .attr('font-size', '8px')
      .attr('pointer-events', 'none')
      .attr('text-anchor', 'middle')
      .text(function(d) {
        return d.type;
      });
  }

  function appendRelationshipToGraph() {
    var relationship = appendRelationship(),
      text = appendTextToRelationship(relationship),
      outline = appendOutlineToRelationship(relationship),
      overlay = appendOverlayToRelationship(relationship);

    return {
      outline: outline,
      overlay: overlay,
      relationship: relationship,
      text: text
    };
  }

  function class2color(cls) {
    var color = classes2colors[cls];

    if (!color) {
      //            color = options.colors[Math.min(numClasses, options.colors.length - 1)];
      color = options.colors[numClasses % options.colors.length];
      classes2colors[cls] = color;
      numClasses++;
    }

    return color;
  }

  function class2darkenColor(cls) {
    return d3.rgb(class2color(cls)).darker(1);
  }

  function clearInfo() {
    info.html('');
  }

  function color() {
    return options.colors[options.colors.length * Math.random() << 0];
  }

  function colors() {
    // d3.schemeCategory10,
    // d3.schemeCategory20,
    return [
      '#68bdf6', // light blue
      '#6dce9e', // green #1
      '#faafc2', // light pink
      '#f2baf6', // purple
      '#ff928c', // light red
      '#fcea7e', // light yellow
      '#ffc766', // light orange
      '#405f9e', // navy blue
      '#a5abb6', // dark gray
      '#78cecb', // green #2,
      '#b88cbb', // dark purple
      '#ced2d9', // light gray
      '#e84646', // dark red
      '#fa5f86', // dark pink
      '#ffab1a', // dark orange
      '#fcda19', // dark yellow
      '#797b80', // black
      '#c9d96f', // pistacchio
      '#47991f', // green #3
      '#70edee', // turquoise
      '#ff75ea'  // pink
    ];
  }

  function contains(array, id) {
    var filter = array.filter(function(elem) {
      return elem.id === id;
    });

    return filter.length > 0;
  }

  function defaultColor() {
    return options.relationshipColor;
  }

  function defaultDarkenColor() {
    return d3.rgb(options.colors[options.colors.length - 1]).darker(1);
  }

  function dragEnded(d) {
    if (!d3.event.active) {
      simulation.alphaTarget(0);
    }

    if (typeof options.onNodeDragEnd === 'function') {
      options.onNodeDragEnd(d);
    }
  }

  function dragged(d) {
    stickNode(d);
  }

  function dragStarted(d) {
    if (!d3.event.active) { 
      simulation.alphaTarget(0.3).restart();
    }

    d.fx = d.x;
    d.fy = d.y;

    if (typeof options.onNodeDragStart === 'function') {
      options.onNodeDragStart(d);
    }
  }

  function extend(obj1, obj2) {
    var obj = {};

    merge(obj, obj1);
    merge(obj, obj2);

    return obj;
  }


  function icon(d) {
    var code;

    if (options.iconMap && options.showIcons && options.icons) {
      if (options.icons[d.label] && options.iconMap[options.icons[d.label]]) {
        code = options.iconMap[options.icons[d.label]];
      } else if (options.iconMap[d.label]) {
        code = options.iconMap[d.label];
      } else if (options.icons[d.label]) {
        code = options.icons[d.label];
      }
    }

    return code;
  }

  function image(d) {
    var i, imagesForLabel, img, imgLevel, label, labelPropertyValue, property, value;

    if (options.images) {
      imagesForLabel = options.imageMap[d.label];

      if (imagesForLabel) {
        imgLevel = 0;

        for (i = 0; i < imagesForLabel.length; i++) {
          labelPropertyValue = imagesForLabel[i].split('|');

          switch (labelPropertyValue.length) {
            case 3:
              value = labelPropertyValue[2];
              /* falls through */
            case 2:
              property = labelPropertyValue[1];
              /* falls through */
            case 1:
              label = labelPropertyValue[0];
          }

          if (d.label === label &&
            (!property || d.properties[property] !== undefined) &&
            (!value || d.properties[property] === value)) {
            if (labelPropertyValue.length > imgLevel) {
              img = options.images[imagesForLabel[i]];
              imgLevel = labelPropertyValue.length;
            }
          }
        }
      }
    }

    return img;
  }

  function init(_selector, _options) {

    initIconMap();

    merge(options, _options);

    if (options.icons) {
      options.showIcons = true;
    }

    if (!options.minCollision) {
      options.minCollision = options.nodeRadius * 2;
    }

    initImageMap();

    selector = _selector;

    container = d3.select(selector);

    container.attr('class', 'neo4jd3')
      .html('');

    if (options.infoPanel) {
      info = InfoPanel.appendInfoPanel(container);
    }

    appendGraph(container);

    simulation = initSimulation();

   if (options.neo4jData) {
    loadNeo4jData(options.neo4jData);
  } else if (options.neo4jDataUrl) {
      loadNeo4jDataFromUrl(options.neo4jDataUrl);
    } else {
      console.error('Error: both neo4jData and neo4jDataUrl are empty!');
    }
  }

  function initIconMap() {
    Object.keys(options.iconMap).forEach(function(key, index) {
      var keys = key.split(','),
        value = options.iconMap[key];

      keys.forEach(function(key) {
        options.iconMap[key] = value;
      });
    });
  }

  function initImageMap() {
    var key, keys, selector;

    for (key in options.images) {
      if (options.images.hasOwnProperty(key)) {
        keys = key.split('|');

        if (!options.imageMap[keys[0]]) {
          options.imageMap[keys[0]] = [key];
        } else {
          options.imageMap[keys[0]].push(key);
        }
      }
    }
  }

  function initSimulation() {
    var simulation = d3.forceSimulation()
    //                           .velocityDecay(0.8)
    //                           .force('x', d3.force().strength(0.002))
    //                           .force('y', d3.force().strength(0.002))
      .force('collide', d3.forceCollide().radius(function(d) {
        return options.minCollision;
      }).iterations(2))
      .force('charge', d3.forceManyBody())
      .force('link', d3.forceLink().id(function(d) {
        return d.id;
      }))
      .force('center', d3.forceCenter(svg.node().parentElement.parentElement.clientWidth / 2, svg.node().parentElement.parentElement.clientHeight / 2))
      .on('tick', function() {
        tick();
      })
      .on('end', function() {
        if (options.zoomFit && !justLoaded) {
          justLoaded = true;
          zoomFit(2);
        }
      });

    return simulation;
  }

  function loadNeo4jData() {
    nodes = [];
    relationships = [];

    updateWithNeo4jData(options.neo4jData);
  }

  function loadNeo4jDataFromUrl(neo4jDataUrl) {
    nodes = [];
    relationships = [];

    d3.json(neo4jDataUrl, function(error, data) {

      updateWithNeo4jData(data);
    });
  }

  function merge(target, source) {
    Object.keys(source).forEach(function(property) {
      target[property] = source[property];
    });
  }

  function neo4jDataToD3Data(data) {
    var graph = {
      nodes: data.nodes,
      relationships: data.links
    };

    return graph;
  }

  function rotate(cx, cy, x, y, angle) {
    var radians = (Math.PI / 180) * angle,
      cos = Math.cos(radians),
      sin = Math.sin(radians),
      nx = (cos * (x - cx)) + (sin * (y - cy)) + cx,
      ny = (cos * (y - cy)) - (sin * (x - cx)) + cy;

    return { x: nx, y: ny };
  }

  function rotatePoint(c, p, angle) {
    return rotate(c.x, c.y, p.x, p.y, angle);
  }

  function rotation(source, target) {
    return Math.atan2(target.y - source.y, target.x - source.x) * 180 / Math.PI;
  }

  function size() {
    return {
      nodes: nodes.length,
      relationships: relationships.length
    };
  }

  function stickNode(d) {
    d.fx = d3.event.x;
    d.fy = d3.event.y;
  }

  function tick() {
    tickNodes();
    tickRelationships();
  }

  function tickNodes() {
    if (node) {
      node.attr('transform', function(d) {
        return 'translate(' + d.x + ', ' + d.y + ')';
      });
    }
  }

  function tickRelationships() {
    if (relationship) {
      relationship.attr('transform', function(d) {
        var angle = rotation(d.source, d.target);
        return 'translate(' + d.source.x + ', ' + d.source.y + ') rotate(' + angle + ')';
      });

      tickRelationshipsTexts();
      tickRelationshipsOutlines();
      tickRelationshipsOverlays();
    }
  }

  function tickRelationshipsOutlines() {
    relationship.each(function(relationship) {
      var rel = d3.select(this),
        outline = rel.select('.outline'),
        text = rel.select('.text'),
        bbox = text.node().getBBox(),
        padding = 3;

      outline.attr('d', function(d) {
        var center = { x: 0, y: 0 },
          angle = rotation(d.source, d.target),
          textBoundingBox = text.node().getBBox(),
          textPadding = 5,
          u = unitaryVector(d.source, d.target),
          textMargin = { x: (d.target.x - d.source.x - (textBoundingBox.width + textPadding) * u.x) * 0.5, y: (d.target.y - d.source.y - (textBoundingBox.width + textPadding) * u.y) * 0.5 },
          n = unitaryNormalVector(d.source, d.target),
          rotatedPointA1 = rotatePoint(center, { x: 0 + (options.nodeRadius + 1) * u.x - n.x, y: 0 + (options.nodeRadius + 1) * u.y - n.y }, angle),
          rotatedPointB1 = rotatePoint(center, { x: textMargin.x - n.x, y: textMargin.y - n.y }, angle),
          rotatedPointC1 = rotatePoint(center, { x: textMargin.x, y: textMargin.y }, angle),
          rotatedPointD1 = rotatePoint(center, { x: 0 + (options.nodeRadius + 1) * u.x, y: 0 + (options.nodeRadius + 1) * u.y }, angle),
          rotatedPointA2 = rotatePoint(center, { x: d.target.x - d.source.x - textMargin.x - n.x, y: d.target.y - d.source.y - textMargin.y - n.y }, angle),
          rotatedPointB2 = rotatePoint(center, { x: d.target.x - d.source.x - (options.nodeRadius + 1) * u.x - n.x - u.x * options.arrowSize, y: d.target.y - d.source.y - (options.nodeRadius + 1) * u.y - n.y - u.y * options.arrowSize }, angle),
          rotatedPointC2 = rotatePoint(center, { x: d.target.x - d.source.x - (options.nodeRadius + 1) * u.x - n.x + (n.x - u.x) * options.arrowSize, y: d.target.y - d.source.y - (options.nodeRadius + 1) * u.y - n.y + (n.y - u.y) * options.arrowSize }, angle),
          rotatedPointD2 = rotatePoint(center, { x: d.target.x - d.source.x - (options.nodeRadius + 1) * u.x, y: d.target.y - d.source.y - (options.nodeRadius + 1) * u.y }, angle),
          rotatedPointE2 = rotatePoint(center, { x: d.target.x - d.source.x - (options.nodeRadius + 1) * u.x + (- n.x - u.x) * options.arrowSize, y: d.target.y - d.source.y - (options.nodeRadius + 1) * u.y + (- n.y - u.y) * options.arrowSize }, angle),
          rotatedPointF2 = rotatePoint(center, { x: d.target.x - d.source.x - (options.nodeRadius + 1) * u.x - u.x * options.arrowSize, y: d.target.y - d.source.y - (options.nodeRadius + 1) * u.y - u.y * options.arrowSize }, angle),
          rotatedPointG2 = rotatePoint(center, { x: d.target.x - d.source.x - textMargin.x, y: d.target.y - d.source.y - textMargin.y }, angle);

        return 'M ' + rotatedPointA1.x + ' ' + rotatedPointA1.y +
          ' L ' + rotatedPointB1.x + ' ' + rotatedPointB1.y +
          ' L ' + rotatedPointC1.x + ' ' + rotatedPointC1.y +
          ' L ' + rotatedPointD1.x + ' ' + rotatedPointD1.y +
          ' Z M ' + rotatedPointA2.x + ' ' + rotatedPointA2.y +
          ' L ' + rotatedPointB2.x + ' ' + rotatedPointB2.y +
          ' L ' + rotatedPointC2.x + ' ' + rotatedPointC2.y +
          ' L ' + rotatedPointD2.x + ' ' + rotatedPointD2.y +
          ' L ' + rotatedPointE2.x + ' ' + rotatedPointE2.y +
          ' L ' + rotatedPointF2.x + ' ' + rotatedPointF2.y +
          ' L ' + rotatedPointG2.x + ' ' + rotatedPointG2.y +
          ' Z';
      });
    });
  }

  function tickRelationshipsOverlays() {
    relationshipOverlay.attr('d', function(d) {
      var center = { x: 0, y: 0 },
        angle = rotation(d.source, d.target),
        n1 = unitaryNormalVector(d.source, d.target),
        n = unitaryNormalVector(d.source, d.target, 50),
        rotatedPointA = rotatePoint(center, { x: 0 - n.x, y: 0 - n.y }, angle),
        rotatedPointB = rotatePoint(center, { x: d.target.x - d.source.x - n.x, y: d.target.y - d.source.y - n.y }, angle),
        rotatedPointC = rotatePoint(center, { x: d.target.x - d.source.x + n.x - n1.x, y: d.target.y - d.source.y + n.y - n1.y }, angle),
        rotatedPointD = rotatePoint(center, { x: 0 + n.x - n1.x, y: 0 + n.y - n1.y }, angle);

      return 'M ' + rotatedPointA.x + ' ' + rotatedPointA.y +
        ' L ' + rotatedPointB.x + ' ' + rotatedPointB.y +
        ' L ' + rotatedPointC.x + ' ' + rotatedPointC.y +
        ' L ' + rotatedPointD.x + ' ' + rotatedPointD.y +
        ' Z';
    });
  }

  function tickRelationshipsTexts() {
    relationshipText.attr('transform', function(d) {
      var angle = (rotation(d.source, d.target) + 360) % 360,
        mirror = angle > 90 && angle < 270,
        center = { x: 0, y: 0 },
        n = unitaryNormalVector(d.source, d.target),
        nWeight = mirror ? 2 : -3,
        point = { x: (d.target.x - d.source.x) * 0.5 + n.x * nWeight, y: (d.target.y - d.source.y) * 0.5 + n.y * nWeight },
        rotatedPoint = rotatePoint(center, point, angle);

      return 'translate(' + rotatedPoint.x + ', ' + rotatedPoint.y + ') rotate(' + (mirror ? 180 : 0) + ')';
    });
  }

  function toString(d) {
    var s = d.label ? d.label : d.type;

    s += ' (<id>: ' + d.label;


    s += ')';

    return s;
  }

  function unitaryNormalVector(source, target, newLength) {
    var center = { x: 0, y: 0 },
      vector = unitaryVector(source, target, newLength);

    return rotatePoint(center, vector, 90);
  }

  function unitaryVector(source, target, newLength) {
    var length = Math.sqrt(Math.pow(target.x - source.x, 2) + Math.pow(target.y - source.y, 2)) / Math.sqrt(newLength || 1);

    return {
      x: (target.x - source.x) / length,
      y: (target.y - source.y) / length,
    };
  }

  function updateWithD3Data(d3Data) {
    updateNodesAndRelationships(d3Data.nodes, d3Data.relationships);
  }

  function updateWithNeo4jData(neo4jData) {
    var d3Data = neo4jDataToD3Data(neo4jData);
    updateWithD3Data(d3Data);
  }

  function updateNodes(n) {
    Array.prototype.push.apply(nodes, n);

    node = svgNodes.selectAll('.node')
      .data(nodes, function(d) { return d.id; });
    var nodeEnter = appendNodeToGraph();
    node = nodeEnter.merge(node);
  }

  function updateNodesAndRelationships(n, r) {
    updateRelationships(r);
    updateNodes(n);

    simulation.nodes(nodes);
    simulation.force('link').links(relationships);
  }

  function updateRelationships(r) {
    Array.prototype.push.apply(relationships, r);

    relationship = svgRelationships.selectAll('.relationship')
    // .data(relationships, function(d) { return d.id; });
      .data(relationships);

    var relationshipEnter = appendRelationshipToGraph();

    relationship = relationshipEnter.relationship.merge(relationship);

    relationshipOutline = svg.selectAll('.relationship .outline');
    relationshipOutline = relationshipEnter.outline.merge(relationshipOutline);

    relationshipOverlay = svg.selectAll('.relationship .overlay');
    relationshipOverlay = relationshipEnter.overlay.merge(relationshipOverlay);

    relationshipText = svg.selectAll('.relationship .text');
    relationshipText = relationshipEnter.text.merge(relationshipText);
  }

  function version() {
    return VERSION;
  }

  function zoomFit(transitionDuration) {
    var bounds = svg.node().getBBox(),
      parent = svg.node().parentElement.parentElement,
      fullWidth = parent.clientWidth,
      fullHeight = parent.clientHeight,
      width = bounds.width,
      height = bounds.height,
      midX = bounds.x + width / 2,
      midY = bounds.y + height / 2;

    if (width === 0 || height === 0) {
      return; // nothing to fit
    }

    svgScale = 0.85 / Math.max(width / fullWidth, height / fullHeight);
    svgTranslate = [fullWidth / 2 - svgScale * midX, fullHeight / 2 - svgScale * midY];

    svg.attr('transform', 'translate(' + svgTranslate[0] + ', ' + svgTranslate[1] + ') scale(' + svgScale + ')');
    //        smoothTransform(svgTranslate, svgScale);
  }

  init(_selector, _options);

  return {
    neo4jDataToD3Data: neo4jDataToD3Data,
    size: size,
    updateWithD3Data: updateWithD3Data,
    updateWithNeo4jData: updateWithNeo4jData,
    version: version
  };
}

module.exports = Neo4jD3;

},{"./fontawesome.js":2,"./infobar.js":3}]},{},[1])(1)
});

//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCJzcmMvbWFpbi9pbmRleC5qcyIsInNyYy9tYWluL3NjcmlwdHMvZm9udGF3ZXNvbWUuanMiLCJzcmMvbWFpbi9zY3JpcHRzL2luZm9iYXIuanMiLCJzcmMvbWFpbi9zY3JpcHRzL25lbzRqZDMuanMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FDTEE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQ3BvQkE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUNoRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uKCl7ZnVuY3Rpb24gcihlLG4sdCl7ZnVuY3Rpb24gbyhpLGYpe2lmKCFuW2ldKXtpZighZVtpXSl7dmFyIGM9XCJmdW5jdGlvblwiPT10eXBlb2YgcmVxdWlyZSYmcmVxdWlyZTtpZighZiYmYylyZXR1cm4gYyhpLCEwKTtpZih1KXJldHVybiB1KGksITApO3ZhciBhPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIraStcIidcIik7dGhyb3cgYS5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGF9dmFyIHA9bltpXT17ZXhwb3J0czp7fX07ZVtpXVswXS5jYWxsKHAuZXhwb3J0cyxmdW5jdGlvbihyKXt2YXIgbj1lW2ldWzFdW3JdO3JldHVybiBvKG58fHIpfSxwLHAuZXhwb3J0cyxyLGUsbix0KX1yZXR1cm4gbltpXS5leHBvcnRzfWZvcih2YXIgdT1cImZ1bmN0aW9uXCI9PXR5cGVvZiByZXF1aXJlJiZyZXF1aXJlLGk9MDtpPHQubGVuZ3RoO2krKylvKHRbaV0pO3JldHVybiBvfXJldHVybiByfSkoKSIsIid1c2Ugc3RyaWN0JztcblxudmFyIG5lbzRqZDMgPSByZXF1aXJlKCcuL3NjcmlwdHMvbmVvNGpkMycpO1xuXG5tb2R1bGUuZXhwb3J0cyA9IG5lbzRqZDM7XG4iLCJmdW5jdGlvbiBmb250QXdlc29tZUljb25zKCkge1xuICByZXR1cm4ge1xuICAgIFwiZ2xhc3NcIjogXCJmMDAwXCIsXG4gICAgXCJtdXNpY1wiOiBcImYwMDFcIixcbiAgICBcInNlYXJjaFwiOiBcImYwMDJcIixcbiAgICBcImVudmVsb3BlLW9cIjogXCJmMDAzXCIsXG4gICAgXCJoZWFydFwiOiBcImYwMDRcIixcbiAgICBcInN0YXJcIjogXCJmMDA1XCIsXG4gICAgXCJzdGFyLW9cIjogXCJmMDA2XCIsXG4gICAgXCJ1c2VyXCI6IFwiZjAwN1wiLFxuICAgIFwiZmlsbVwiOiBcImYwMDhcIixcbiAgICBcInRoLWxhcmdlXCI6IFwiZjAwOVwiLFxuICAgIFwidGhcIjogXCJmMDBhXCIsXG4gICAgXCJ0aC1saXN0XCI6IFwiZjAwYlwiLFxuICAgIFwiY2hlY2tcIjogXCJmMDBjXCIsXG4gICAgXCJyZW1vdmUsY2xvc2UsdGltZXNcIjogXCJmMDBkXCIsXG4gICAgXCJzZWFyY2gtcGx1c1wiOiBcImYwMGVcIixcbiAgICBcInNlYXJjaC1taW51c1wiOiBcImYwMTBcIixcbiAgICBcInBvd2VyLW9mZlwiOiBcImYwMTFcIixcbiAgICBcInNpZ25hbFwiOiBcImYwMTJcIixcbiAgICBcImdlYXIsY29nXCI6IFwiZjAxM1wiLFxuICAgIFwidHJhc2gtb1wiOiBcImYwMTRcIixcbiAgICBcImhvbWVcIjogXCJmMDE1XCIsXG4gICAgXCJmaWxlLW9cIjogXCJmMDE2XCIsXG4gICAgXCJjbG9jay1vXCI6IFwiZjAxN1wiLFxuICAgIFwicm9hZFwiOiBcImYwMThcIixcbiAgICBcImRvd25sb2FkXCI6IFwiZjAxOVwiLFxuICAgIFwiYXJyb3ctY2lyY2xlLW8tZG93blwiOiBcImYwMWFcIixcbiAgICBcImFycm93LWNpcmNsZS1vLXVwXCI6IFwiZjAxYlwiLFxuICAgIFwiaW5ib3hcIjogXCJmMDFjXCIsXG4gICAgXCJwbGF5LWNpcmNsZS1vXCI6IFwiZjAxZFwiLFxuICAgIFwicm90YXRlLXJpZ2h0LHJlcGVhdFwiOiBcImYwMWVcIixcbiAgICBcInJlZnJlc2hcIjogXCJmMDIxXCIsXG4gICAgXCJsaXN0LWFsdFwiOiBcImYwMjJcIixcbiAgICBcImxvY2tcIjogXCJmMDIzXCIsXG4gICAgXCJmbGFnXCI6IFwiZjAyNFwiLFxuICAgIFwiaGVhZHBob25lc1wiOiBcImYwMjVcIixcbiAgICBcInZvbHVtZS1vZmZcIjogXCJmMDI2XCIsXG4gICAgXCJ2b2x1bWUtZG93blwiOiBcImYwMjdcIixcbiAgICBcInZvbHVtZS11cFwiOiBcImYwMjhcIixcbiAgICBcInFyY29kZVwiOiBcImYwMjlcIixcbiAgICBcImJhcmNvZGVcIjogXCJmMDJhXCIsXG4gICAgXCJ0YWdcIjogXCJmMDJiXCIsXG4gICAgXCJ0YWdzXCI6IFwiZjAyY1wiLFxuICAgIFwiYm9va1wiOiBcImYwMmRcIixcbiAgICBcImJvb2ttYXJrXCI6IFwiZjAyZVwiLFxuICAgIFwicHJpbnRcIjogXCJmMDJmXCIsXG4gICAgXCJjYW1lcmFcIjogXCJmMDMwXCIsXG4gICAgXCJmb250XCI6IFwiZjAzMVwiLFxuICAgIFwiYm9sZFwiOiBcImYwMzJcIixcbiAgICBcIml0YWxpY1wiOiBcImYwMzNcIixcbiAgICBcInRleHQtaGVpZ2h0XCI6IFwiZjAzNFwiLFxuICAgIFwidGV4dC13aWR0aFwiOiBcImYwMzVcIixcbiAgICBcImFsaWduLWxlZnRcIjogXCJmMDM2XCIsXG4gICAgXCJhbGlnbi1jZW50ZXJcIjogXCJmMDM3XCIsXG4gICAgXCJhbGlnbi1yaWdodFwiOiBcImYwMzhcIixcbiAgICBcImFsaWduLWp1c3RpZnlcIjogXCJmMDM5XCIsXG4gICAgXCJsaXN0XCI6IFwiZjAzYVwiLFxuICAgIFwiZGVkZW50LG91dGRlbnRcIjogXCJmMDNiXCIsXG4gICAgXCJpbmRlbnRcIjogXCJmMDNjXCIsXG4gICAgXCJ2aWRlby1jYW1lcmFcIjogXCJmMDNkXCIsXG4gICAgXCJwaG90byxpbWFnZSxwaWN0dXJlLW9cIjogXCJmMDNlXCIsXG4gICAgXCJwZW5jaWxcIjogXCJmMDQwXCIsXG4gICAgXCJtYXAtbWFya2VyXCI6IFwiZjA0MVwiLFxuICAgIFwiYWRqdXN0XCI6IFwiZjA0MlwiLFxuICAgIFwidGludFwiOiBcImYwNDNcIixcbiAgICBcImVkaXQscGVuY2lsLXNxdWFyZS1vXCI6IFwiZjA0NFwiLFxuICAgIFwic2hhcmUtc3F1YXJlLW9cIjogXCJmMDQ1XCIsXG4gICAgXCJjaGVjay1zcXVhcmUtb1wiOiBcImYwNDZcIixcbiAgICBcImFycm93c1wiOiBcImYwNDdcIixcbiAgICBcInN0ZXAtYmFja3dhcmRcIjogXCJmMDQ4XCIsXG4gICAgXCJmYXN0LWJhY2t3YXJkXCI6IFwiZjA0OVwiLFxuICAgIFwiYmFja3dhcmRcIjogXCJmMDRhXCIsXG4gICAgXCJwbGF5XCI6IFwiZjA0YlwiLFxuICAgIFwicGF1c2VcIjogXCJmMDRjXCIsXG4gICAgXCJzdG9wXCI6IFwiZjA0ZFwiLFxuICAgIFwiZm9yd2FyZFwiOiBcImYwNGVcIixcbiAgICBcImZhc3QtZm9yd2FyZFwiOiBcImYwNTBcIixcbiAgICBcInN0ZXAtZm9yd2FyZFwiOiBcImYwNTFcIixcbiAgICBcImVqZWN0XCI6IFwiZjA1MlwiLFxuICAgIFwiY2hldnJvbi1sZWZ0XCI6IFwiZjA1M1wiLFxuICAgIFwiY2hldnJvbi1yaWdodFwiOiBcImYwNTRcIixcbiAgICBcInBsdXMtY2lyY2xlXCI6IFwiZjA1NVwiLFxuICAgIFwibWludXMtY2lyY2xlXCI6IFwiZjA1NlwiLFxuICAgIFwidGltZXMtY2lyY2xlXCI6IFwiZjA1N1wiLFxuICAgIFwiY2hlY2stY2lyY2xlXCI6IFwiZjA1OFwiLFxuICAgIFwicXVlc3Rpb24tY2lyY2xlXCI6IFwiZjA1OVwiLFxuICAgIFwiaW5mby1jaXJjbGVcIjogXCJmMDVhXCIsXG4gICAgXCJjcm9zc2hhaXJzXCI6IFwiZjA1YlwiLFxuICAgIFwidGltZXMtY2lyY2xlLW9cIjogXCJmMDVjXCIsXG4gICAgXCJjaGVjay1jaXJjbGUtb1wiOiBcImYwNWRcIixcbiAgICBcImJhblwiOiBcImYwNWVcIixcbiAgICBcImFycm93LWxlZnRcIjogXCJmMDYwXCIsXG4gICAgXCJhcnJvdy1yaWdodFwiOiBcImYwNjFcIixcbiAgICBcImFycm93LXVwXCI6IFwiZjA2MlwiLFxuICAgIFwiYXJyb3ctZG93blwiOiBcImYwNjNcIixcbiAgICBcIm1haWwtZm9yd2FyZCxzaGFyZVwiOiBcImYwNjRcIixcbiAgICBcImV4cGFuZFwiOiBcImYwNjVcIixcbiAgICBcImNvbXByZXNzXCI6IFwiZjA2NlwiLFxuICAgIFwicGx1c1wiOiBcImYwNjdcIixcbiAgICBcIm1pbnVzXCI6IFwiZjA2OFwiLFxuICAgIFwiYXN0ZXJpc2tcIjogXCJmMDY5XCIsXG4gICAgXCJleGNsYW1hdGlvbi1jaXJjbGVcIjogXCJmMDZhXCIsXG4gICAgXCJnaWZ0XCI6IFwiZjA2YlwiLFxuICAgIFwibGVhZlwiOiBcImYwNmNcIixcbiAgICBcImZpcmVcIjogXCJmMDZkXCIsXG4gICAgXCJleWVcIjogXCJmMDZlXCIsXG4gICAgXCJleWUtc2xhc2hcIjogXCJmMDcwXCIsXG4gICAgXCJ3YXJuaW5nLGV4Y2xhbWF0aW9uLXRyaWFuZ2xlXCI6IFwiZjA3MVwiLFxuICAgIFwicGxhbmVcIjogXCJmMDcyXCIsXG4gICAgXCJjYWxlbmRhclwiOiBcImYwNzNcIixcbiAgICBcInJhbmRvbVwiOiBcImYwNzRcIixcbiAgICBcImNvbW1lbnRcIjogXCJmMDc1XCIsXG4gICAgXCJtYWduZXRcIjogXCJmMDc2XCIsXG4gICAgXCJjaGV2cm9uLXVwXCI6IFwiZjA3N1wiLFxuICAgIFwiY2hldnJvbi1kb3duXCI6IFwiZjA3OFwiLFxuICAgIFwicmV0d2VldFwiOiBcImYwNzlcIixcbiAgICBcInNob3BwaW5nLWNhcnRcIjogXCJmMDdhXCIsXG4gICAgXCJmb2xkZXJcIjogXCJmMDdiXCIsXG4gICAgXCJmb2xkZXItb3BlblwiOiBcImYwN2NcIixcbiAgICBcImFycm93cy12XCI6IFwiZjA3ZFwiLFxuICAgIFwiYXJyb3dzLWhcIjogXCJmMDdlXCIsXG4gICAgXCJiYXItY2hhcnQtbyxiYXItY2hhcnRcIjogXCJmMDgwXCIsXG4gICAgXCJ0d2l0dGVyLXNxdWFyZVwiOiBcImYwODFcIixcbiAgICBcImZhY2Vib29rLXNxdWFyZVwiOiBcImYwODJcIixcbiAgICBcImNhbWVyYS1yZXRyb1wiOiBcImYwODNcIixcbiAgICBcImtleVwiOiBcImYwODRcIixcbiAgICBcImdlYXJzLGNvZ3NcIjogXCJmMDg1XCIsXG4gICAgXCJjb21tZW50c1wiOiBcImYwODZcIixcbiAgICBcInRodW1icy1vLXVwXCI6IFwiZjA4N1wiLFxuICAgIFwidGh1bWJzLW8tZG93blwiOiBcImYwODhcIixcbiAgICBcInN0YXItaGFsZlwiOiBcImYwODlcIixcbiAgICBcImhlYXJ0LW9cIjogXCJmMDhhXCIsXG4gICAgXCJzaWduLW91dFwiOiBcImYwOGJcIixcbiAgICBcImxpbmtlZGluLXNxdWFyZVwiOiBcImYwOGNcIixcbiAgICBcInRodW1iLXRhY2tcIjogXCJmMDhkXCIsXG4gICAgXCJleHRlcm5hbC1saW5rXCI6IFwiZjA4ZVwiLFxuICAgIFwic2lnbi1pblwiOiBcImYwOTBcIixcbiAgICBcInRyb3BoeVwiOiBcImYwOTFcIixcbiAgICBcImdpdGh1Yi1zcXVhcmVcIjogXCJmMDkyXCIsXG4gICAgXCJ1cGxvYWRcIjogXCJmMDkzXCIsXG4gICAgXCJsZW1vbi1vXCI6IFwiZjA5NFwiLFxuICAgIFwicGhvbmVcIjogXCJmMDk1XCIsXG4gICAgXCJzcXVhcmUtb1wiOiBcImYwOTZcIixcbiAgICBcImJvb2ttYXJrLW9cIjogXCJmMDk3XCIsXG4gICAgXCJwaG9uZS1zcXVhcmVcIjogXCJmMDk4XCIsXG4gICAgXCJ0d2l0dGVyXCI6IFwiZjA5OVwiLFxuICAgIFwiZmFjZWJvb2stZixmYWNlYm9va1wiOiBcImYwOWFcIixcbiAgICBcImdpdGh1YlwiOiBcImYwOWJcIixcbiAgICBcInVubG9ja1wiOiBcImYwOWNcIixcbiAgICBcImNyZWRpdC1jYXJkXCI6IFwiZjA5ZFwiLFxuICAgIFwiZmVlZCxyc3NcIjogXCJmMDllXCIsXG4gICAgXCJoZGQtb1wiOiBcImYwYTBcIixcbiAgICBcImJ1bGxob3JuXCI6IFwiZjBhMVwiLFxuICAgIFwiYmVsbFwiOiBcImYwZjNcIixcbiAgICBcImNlcnRpZmljYXRlXCI6IFwiZjBhM1wiLFxuICAgIFwiaGFuZC1vLXJpZ2h0XCI6IFwiZjBhNFwiLFxuICAgIFwiaGFuZC1vLWxlZnRcIjogXCJmMGE1XCIsXG4gICAgXCJoYW5kLW8tdXBcIjogXCJmMGE2XCIsXG4gICAgXCJoYW5kLW8tZG93blwiOiBcImYwYTdcIixcbiAgICBcImFycm93LWNpcmNsZS1sZWZ0XCI6IFwiZjBhOFwiLFxuICAgIFwiYXJyb3ctY2lyY2xlLXJpZ2h0XCI6IFwiZjBhOVwiLFxuICAgIFwiYXJyb3ctY2lyY2xlLXVwXCI6IFwiZjBhYVwiLFxuICAgIFwiYXJyb3ctY2lyY2xlLWRvd25cIjogXCJmMGFiXCIsXG4gICAgXCJnbG9iZVwiOiBcImYwYWNcIixcbiAgICBcIndyZW5jaFwiOiBcImYwYWRcIixcbiAgICBcInRhc2tzXCI6IFwiZjBhZVwiLFxuICAgIFwiZmlsdGVyXCI6IFwiZjBiMFwiLFxuICAgIFwiYnJpZWZjYXNlXCI6IFwiZjBiMVwiLFxuICAgIFwiYXJyb3dzLWFsdFwiOiBcImYwYjJcIixcbiAgICBcImdyb3VwLHVzZXJzXCI6IFwiZjBjMFwiLFxuICAgIFwiY2hhaW4sbGlua1wiOiBcImYwYzFcIixcbiAgICBcImNsb3VkXCI6IFwiZjBjMlwiLFxuICAgIFwiZmxhc2tcIjogXCJmMGMzXCIsXG4gICAgXCJjdXQsc2Npc3NvcnNcIjogXCJmMGM0XCIsXG4gICAgXCJjb3B5LGZpbGVzLW9cIjogXCJmMGM1XCIsXG4gICAgXCJwYXBlcmNsaXBcIjogXCJmMGM2XCIsXG4gICAgXCJzYXZlLGZsb3BweS1vXCI6IFwiZjBjN1wiLFxuICAgIFwic3F1YXJlXCI6IFwiZjBjOFwiLFxuICAgIFwibmF2aWNvbixyZW9yZGVyLGJhcnNcIjogXCJmMGM5XCIsXG4gICAgXCJsaXN0LXVsXCI6IFwiZjBjYVwiLFxuICAgIFwibGlzdC1vbFwiOiBcImYwY2JcIixcbiAgICBcInN0cmlrZXRocm91Z2hcIjogXCJmMGNjXCIsXG4gICAgXCJ1bmRlcmxpbmVcIjogXCJmMGNkXCIsXG4gICAgXCJ0YWJsZVwiOiBcImYwY2VcIixcbiAgICBcIm1hZ2ljXCI6IFwiZjBkMFwiLFxuICAgIFwidHJ1Y2tcIjogXCJmMGQxXCIsXG4gICAgXCJwaW50ZXJlc3RcIjogXCJmMGQyXCIsXG4gICAgXCJwaW50ZXJlc3Qtc3F1YXJlXCI6IFwiZjBkM1wiLFxuICAgIFwiZ29vZ2xlLXBsdXMtc3F1YXJlXCI6IFwiZjBkNFwiLFxuICAgIFwiZ29vZ2xlLXBsdXNcIjogXCJmMGQ1XCIsXG4gICAgXCJtb25leVwiOiBcImYwZDZcIixcbiAgICBcImNhcmV0LWRvd25cIjogXCJmMGQ3XCIsXG4gICAgXCJjYXJldC11cFwiOiBcImYwZDhcIixcbiAgICBcImNhcmV0LWxlZnRcIjogXCJmMGQ5XCIsXG4gICAgXCJjYXJldC1yaWdodFwiOiBcImYwZGFcIixcbiAgICBcImNvbHVtbnNcIjogXCJmMGRiXCIsXG4gICAgXCJ1bnNvcnRlZCxzb3J0XCI6IFwiZjBkY1wiLFxuICAgIFwic29ydC1kb3duLHNvcnQtZGVzY1wiOiBcImYwZGRcIixcbiAgICBcInNvcnQtdXAsc29ydC1hc2NcIjogXCJmMGRlXCIsXG4gICAgXCJlbnZlbG9wZVwiOiBcImYwZTBcIixcbiAgICBcImxpbmtlZGluXCI6IFwiZjBlMVwiLFxuICAgIFwicm90YXRlLWxlZnQsdW5kb1wiOiBcImYwZTJcIixcbiAgICBcImxlZ2FsLGdhdmVsXCI6IFwiZjBlM1wiLFxuICAgIFwiZGFzaGJvYXJkLHRhY2hvbWV0ZXJcIjogXCJmMGU0XCIsXG4gICAgXCJjb21tZW50LW9cIjogXCJmMGU1XCIsXG4gICAgXCJjb21tZW50cy1vXCI6IFwiZjBlNlwiLFxuICAgIFwiZmxhc2gsYm9sdFwiOiBcImYwZTdcIixcbiAgICBcInNpdGVtYXBcIjogXCJmMGU4XCIsXG4gICAgXCJ1bWJyZWxsYVwiOiBcImYwZTlcIixcbiAgICBcInBhc3RlLGNsaXBib2FyZFwiOiBcImYwZWFcIixcbiAgICBcImxpZ2h0YnVsYi1vXCI6IFwiZjBlYlwiLFxuICAgIFwiZXhjaGFuZ2VcIjogXCJmMGVjXCIsXG4gICAgXCJjbG91ZC1kb3dubG9hZFwiOiBcImYwZWRcIixcbiAgICBcImNsb3VkLXVwbG9hZFwiOiBcImYwZWVcIixcbiAgICBcInVzZXItbWRcIjogXCJmMGYwXCIsXG4gICAgXCJzdGV0aG9zY29wZVwiOiBcImYwZjFcIixcbiAgICBcInN1aXRjYXNlXCI6IFwiZjBmMlwiLFxuICAgIFwiYmVsbC1vXCI6IFwiZjBhMlwiLFxuICAgIFwiY29mZmVlXCI6IFwiZjBmNFwiLFxuICAgIFwiY3V0bGVyeVwiOiBcImYwZjVcIixcbiAgICBcImZpbGUtdGV4dC1vXCI6IFwiZjBmNlwiLFxuICAgIFwiYnVpbGRpbmctb1wiOiBcImYwZjdcIixcbiAgICBcImhvc3BpdGFsLW9cIjogXCJmMGY4XCIsXG4gICAgXCJhbWJ1bGFuY2VcIjogXCJmMGY5XCIsXG4gICAgXCJtZWRraXRcIjogXCJmMGZhXCIsXG4gICAgXCJmaWdodGVyLWpldFwiOiBcImYwZmJcIixcbiAgICBcImJlZXJcIjogXCJmMGZjXCIsXG4gICAgXCJoLXNxdWFyZVwiOiBcImYwZmRcIixcbiAgICBcInBsdXMtc3F1YXJlXCI6IFwiZjBmZVwiLFxuICAgIFwiYW5nbGUtZG91YmxlLWxlZnRcIjogXCJmMTAwXCIsXG4gICAgXCJhbmdsZS1kb3VibGUtcmlnaHRcIjogXCJmMTAxXCIsXG4gICAgXCJhbmdsZS1kb3VibGUtdXBcIjogXCJmMTAyXCIsXG4gICAgXCJhbmdsZS1kb3VibGUtZG93blwiOiBcImYxMDNcIixcbiAgICBcImFuZ2xlLWxlZnRcIjogXCJmMTA0XCIsXG4gICAgXCJhbmdsZS1yaWdodFwiOiBcImYxMDVcIixcbiAgICBcImFuZ2xlLXVwXCI6IFwiZjEwNlwiLFxuICAgIFwiYW5nbGUtZG93blwiOiBcImYxMDdcIixcbiAgICBcImRlc2t0b3BcIjogXCJmMTA4XCIsXG4gICAgXCJsYXB0b3BcIjogXCJmMTA5XCIsXG4gICAgXCJ0YWJsZXRcIjogXCJmMTBhXCIsXG4gICAgXCJtb2JpbGUtcGhvbmUsbW9iaWxlXCI6IFwiZjEwYlwiLFxuICAgIFwiY2lyY2xlLW9cIjogXCJmMTBjXCIsXG4gICAgXCJxdW90ZS1sZWZ0XCI6IFwiZjEwZFwiLFxuICAgIFwicXVvdGUtcmlnaHRcIjogXCJmMTBlXCIsXG4gICAgXCJzcGlubmVyXCI6IFwiZjExMFwiLFxuICAgIFwiY2lyY2xlXCI6IFwiZjExMVwiLFxuICAgIFwibWFpbC1yZXBseSxyZXBseVwiOiBcImYxMTJcIixcbiAgICBcImdpdGh1Yi1hbHRcIjogXCJmMTEzXCIsXG4gICAgXCJmb2xkZXItb1wiOiBcImYxMTRcIixcbiAgICBcImZvbGRlci1vcGVuLW9cIjogXCJmMTE1XCIsXG4gICAgXCJzbWlsZS1vXCI6IFwiZjExOFwiLFxuICAgIFwiZnJvd24tb1wiOiBcImYxMTlcIixcbiAgICBcIm1laC1vXCI6IFwiZjExYVwiLFxuICAgIFwiZ2FtZXBhZFwiOiBcImYxMWJcIixcbiAgICBcImtleWJvYXJkLW9cIjogXCJmMTFjXCIsXG4gICAgXCJmbGFnLW9cIjogXCJmMTFkXCIsXG4gICAgXCJmbGFnLWNoZWNrZXJlZFwiOiBcImYxMWVcIixcbiAgICBcInRlcm1pbmFsXCI6IFwiZjEyMFwiLFxuICAgIFwiY29kZVwiOiBcImYxMjFcIixcbiAgICBcIm1haWwtcmVwbHktYWxsLHJlcGx5LWFsbFwiOiBcImYxMjJcIixcbiAgICBcInN0YXItaGFsZi1lbXB0eSxzdGFyLWhhbGYtZnVsbCxzdGFyLWhhbGYtb1wiOiBcImYxMjNcIixcbiAgICBcImxvY2F0aW9uLWFycm93XCI6IFwiZjEyNFwiLFxuICAgIFwiY3JvcFwiOiBcImYxMjVcIixcbiAgICBcImNvZGUtZm9ya1wiOiBcImYxMjZcIixcbiAgICBcInVubGluayxjaGFpbi1icm9rZW5cIjogXCJmMTI3XCIsXG4gICAgXCJxdWVzdGlvblwiOiBcImYxMjhcIixcbiAgICBcImluZm9cIjogXCJmMTI5XCIsXG4gICAgXCJleGNsYW1hdGlvblwiOiBcImYxMmFcIixcbiAgICBcInN1cGVyc2NyaXB0XCI6IFwiZjEyYlwiLFxuICAgIFwic3Vic2NyaXB0XCI6IFwiZjEyY1wiLFxuICAgIFwiZXJhc2VyXCI6IFwiZjEyZFwiLFxuICAgIFwicHV6emxlLXBpZWNlXCI6IFwiZjEyZVwiLFxuICAgIFwibWljcm9waG9uZVwiOiBcImYxMzBcIixcbiAgICBcIm1pY3JvcGhvbmUtc2xhc2hcIjogXCJmMTMxXCIsXG4gICAgXCJzaGllbGRcIjogXCJmMTMyXCIsXG4gICAgXCJjYWxlbmRhci1vXCI6IFwiZjEzM1wiLFxuICAgIFwiZmlyZS1leHRpbmd1aXNoZXJcIjogXCJmMTM0XCIsXG4gICAgXCJyb2NrZXRcIjogXCJmMTM1XCIsXG4gICAgXCJtYXhjZG5cIjogXCJmMTM2XCIsXG4gICAgXCJjaGV2cm9uLWNpcmNsZS1sZWZ0XCI6IFwiZjEzN1wiLFxuICAgIFwiY2hldnJvbi1jaXJjbGUtcmlnaHRcIjogXCJmMTM4XCIsXG4gICAgXCJjaGV2cm9uLWNpcmNsZS11cFwiOiBcImYxMzlcIixcbiAgICBcImNoZXZyb24tY2lyY2xlLWRvd25cIjogXCJmMTNhXCIsXG4gICAgXCJodG1sNVwiOiBcImYxM2JcIixcbiAgICBcImNzczNcIjogXCJmMTNjXCIsXG4gICAgXCJhbmNob3JcIjogXCJmMTNkXCIsXG4gICAgXCJ1bmxvY2stYWx0XCI6IFwiZjEzZVwiLFxuICAgIFwiYnVsbHNleWVcIjogXCJmMTQwXCIsXG4gICAgXCJlbGxpcHNpcy1oXCI6IFwiZjE0MVwiLFxuICAgIFwiZWxsaXBzaXMtdlwiOiBcImYxNDJcIixcbiAgICBcInJzcy1zcXVhcmVcIjogXCJmMTQzXCIsXG4gICAgXCJwbGF5LWNpcmNsZVwiOiBcImYxNDRcIixcbiAgICBcInRpY2tldFwiOiBcImYxNDVcIixcbiAgICBcIm1pbnVzLXNxdWFyZVwiOiBcImYxNDZcIixcbiAgICBcIm1pbnVzLXNxdWFyZS1vXCI6IFwiZjE0N1wiLFxuICAgIFwibGV2ZWwtdXBcIjogXCJmMTQ4XCIsXG4gICAgXCJsZXZlbC1kb3duXCI6IFwiZjE0OVwiLFxuICAgIFwiY2hlY2stc3F1YXJlXCI6IFwiZjE0YVwiLFxuICAgIFwicGVuY2lsLXNxdWFyZVwiOiBcImYxNGJcIixcbiAgICBcImV4dGVybmFsLWxpbmstc3F1YXJlXCI6IFwiZjE0Y1wiLFxuICAgIFwic2hhcmUtc3F1YXJlXCI6IFwiZjE0ZFwiLFxuICAgIFwiY29tcGFzc1wiOiBcImYxNGVcIixcbiAgICBcInRvZ2dsZS1kb3duLGNhcmV0LXNxdWFyZS1vLWRvd25cIjogXCJmMTUwXCIsXG4gICAgXCJ0b2dnbGUtdXAsY2FyZXQtc3F1YXJlLW8tdXBcIjogXCJmMTUxXCIsXG4gICAgXCJ0b2dnbGUtcmlnaHQsY2FyZXQtc3F1YXJlLW8tcmlnaHRcIjogXCJmMTUyXCIsXG4gICAgXCJldXJvLGV1clwiOiBcImYxNTNcIixcbiAgICBcImdicFwiOiBcImYxNTRcIixcbiAgICBcImRvbGxhcix1c2RcIjogXCJmMTU1XCIsXG4gICAgXCJydXBlZSxpbnJcIjogXCJmMTU2XCIsXG4gICAgXCJjbnkscm1iLHllbixqcHlcIjogXCJmMTU3XCIsXG4gICAgXCJydWJsZSxyb3VibGUscnViXCI6IFwiZjE1OFwiLFxuICAgIFwid29uLGtyd1wiOiBcImYxNTlcIixcbiAgICBcImJpdGNvaW4sYnRjXCI6IFwiZjE1YVwiLFxuICAgIFwiZmlsZVwiOiBcImYxNWJcIixcbiAgICBcImZpbGUtdGV4dFwiOiBcImYxNWNcIixcbiAgICBcInNvcnQtYWxwaGEtYXNjXCI6IFwiZjE1ZFwiLFxuICAgIFwic29ydC1hbHBoYS1kZXNjXCI6IFwiZjE1ZVwiLFxuICAgIFwic29ydC1hbW91bnQtYXNjXCI6IFwiZjE2MFwiLFxuICAgIFwic29ydC1hbW91bnQtZGVzY1wiOiBcImYxNjFcIixcbiAgICBcInNvcnQtbnVtZXJpYy1hc2NcIjogXCJmMTYyXCIsXG4gICAgXCJzb3J0LW51bWVyaWMtZGVzY1wiOiBcImYxNjNcIixcbiAgICBcInRodW1icy11cFwiOiBcImYxNjRcIixcbiAgICBcInRodW1icy1kb3duXCI6IFwiZjE2NVwiLFxuICAgIFwieW91dHViZS1zcXVhcmVcIjogXCJmMTY2XCIsXG4gICAgXCJ5b3V0dWJlXCI6IFwiZjE2N1wiLFxuICAgIFwieGluZ1wiOiBcImYxNjhcIixcbiAgICBcInhpbmctc3F1YXJlXCI6IFwiZjE2OVwiLFxuICAgIFwieW91dHViZS1wbGF5XCI6IFwiZjE2YVwiLFxuICAgIFwiZHJvcGJveFwiOiBcImYxNmJcIixcbiAgICBcInN0YWNrLW92ZXJmbG93XCI6IFwiZjE2Y1wiLFxuICAgIFwiaW5zdGFncmFtXCI6IFwiZjE2ZFwiLFxuICAgIFwiZmxpY2tyXCI6IFwiZjE2ZVwiLFxuICAgIFwiYWRuXCI6IFwiZjE3MFwiLFxuICAgIFwiYml0YnVja2V0XCI6IFwiZjE3MVwiLFxuICAgIFwiYml0YnVja2V0LXNxdWFyZVwiOiBcImYxNzJcIixcbiAgICBcInR1bWJsclwiOiBcImYxNzNcIixcbiAgICBcInR1bWJsci1zcXVhcmVcIjogXCJmMTc0XCIsXG4gICAgXCJsb25nLWFycm93LWRvd25cIjogXCJmMTc1XCIsXG4gICAgXCJsb25nLWFycm93LXVwXCI6IFwiZjE3NlwiLFxuICAgIFwibG9uZy1hcnJvdy1sZWZ0XCI6IFwiZjE3N1wiLFxuICAgIFwibG9uZy1hcnJvdy1yaWdodFwiOiBcImYxNzhcIixcbiAgICBcImFwcGxlXCI6IFwiZjE3OVwiLFxuICAgIFwid2luZG93c1wiOiBcImYxN2FcIixcbiAgICBcImFuZHJvaWRcIjogXCJmMTdiXCIsXG4gICAgXCJsaW51eFwiOiBcImYxN2NcIixcbiAgICBcImRyaWJiYmxlXCI6IFwiZjE3ZFwiLFxuICAgIFwic2t5cGVcIjogXCJmMTdlXCIsXG4gICAgXCJmb3Vyc3F1YXJlXCI6IFwiZjE4MFwiLFxuICAgIFwidHJlbGxvXCI6IFwiZjE4MVwiLFxuICAgIFwiZmVtYWxlXCI6IFwiZjE4MlwiLFxuICAgIFwibWFsZVwiOiBcImYxODNcIixcbiAgICBcImdpdHRpcCxncmF0aXBheVwiOiBcImYxODRcIixcbiAgICBcInN1bi1vXCI6IFwiZjE4NVwiLFxuICAgIFwibW9vbi1vXCI6IFwiZjE4NlwiLFxuICAgIFwiYXJjaGl2ZVwiOiBcImYxODdcIixcbiAgICBcImJ1Z1wiOiBcImYxODhcIixcbiAgICBcInZrXCI6IFwiZjE4OVwiLFxuICAgIFwid2VpYm9cIjogXCJmMThhXCIsXG4gICAgXCJyZW5yZW5cIjogXCJmMThiXCIsXG4gICAgXCJwYWdlbGluZXNcIjogXCJmMThjXCIsXG4gICAgXCJzdGFjay1leGNoYW5nZVwiOiBcImYxOGRcIixcbiAgICBcImFycm93LWNpcmNsZS1vLXJpZ2h0XCI6IFwiZjE4ZVwiLFxuICAgIFwiYXJyb3ctY2lyY2xlLW8tbGVmdFwiOiBcImYxOTBcIixcbiAgICBcInRvZ2dsZS1sZWZ0LGNhcmV0LXNxdWFyZS1vLWxlZnRcIjogXCJmMTkxXCIsXG4gICAgXCJkb3QtY2lyY2xlLW9cIjogXCJmMTkyXCIsXG4gICAgXCJ3aGVlbGNoYWlyXCI6IFwiZjE5M1wiLFxuICAgIFwidmltZW8tc3F1YXJlXCI6IFwiZjE5NFwiLFxuICAgIFwidHVya2lzaC1saXJhLHRyeVwiOiBcImYxOTVcIixcbiAgICBcInBsdXMtc3F1YXJlLW9cIjogXCJmMTk2XCIsXG4gICAgXCJzcGFjZS1zaHV0dGxlXCI6IFwiZjE5N1wiLFxuICAgIFwic2xhY2tcIjogXCJmMTk4XCIsXG4gICAgXCJlbnZlbG9wZS1zcXVhcmVcIjogXCJmMTk5XCIsXG4gICAgXCJ3b3JkcHJlc3NcIjogXCJmMTlhXCIsXG4gICAgXCJvcGVuaWRcIjogXCJmMTliXCIsXG4gICAgXCJpbnN0aXR1dGlvbixiYW5rLHVuaXZlcnNpdHlcIjogXCJmMTljXCIsXG4gICAgXCJtb3J0YXItYm9hcmQsZ3JhZHVhdGlvbi1jYXBcIjogXCJmMTlkXCIsXG4gICAgXCJ5YWhvb1wiOiBcImYxOWVcIixcbiAgICBcImdvb2dsZVwiOiBcImYxYTBcIixcbiAgICBcInJlZGRpdFwiOiBcImYxYTFcIixcbiAgICBcInJlZGRpdC1zcXVhcmVcIjogXCJmMWEyXCIsXG4gICAgXCJzdHVtYmxldXBvbi1jaXJjbGVcIjogXCJmMWEzXCIsXG4gICAgXCJzdHVtYmxldXBvblwiOiBcImYxYTRcIixcbiAgICBcImRlbGljaW91c1wiOiBcImYxYTVcIixcbiAgICBcImRpZ2dcIjogXCJmMWE2XCIsXG4gICAgXCJwaWVkLXBpcGVyLXBwXCI6IFwiZjFhN1wiLFxuICAgIFwicGllZC1waXBlci1hbHRcIjogXCJmMWE4XCIsXG4gICAgXCJkcnVwYWxcIjogXCJmMWE5XCIsXG4gICAgXCJqb29tbGFcIjogXCJmMWFhXCIsXG4gICAgXCJsYW5ndWFnZVwiOiBcImYxYWJcIixcbiAgICBcImZheFwiOiBcImYxYWNcIixcbiAgICBcImJ1aWxkaW5nXCI6IFwiZjFhZFwiLFxuICAgIFwiY2hpbGRcIjogXCJmMWFlXCIsXG4gICAgXCJwYXdcIjogXCJmMWIwXCIsXG4gICAgXCJzcG9vblwiOiBcImYxYjFcIixcbiAgICBcImN1YmVcIjogXCJmMWIyXCIsXG4gICAgXCJjdWJlc1wiOiBcImYxYjNcIixcbiAgICBcImJlaGFuY2VcIjogXCJmMWI0XCIsXG4gICAgXCJiZWhhbmNlLXNxdWFyZVwiOiBcImYxYjVcIixcbiAgICBcInN0ZWFtXCI6IFwiZjFiNlwiLFxuICAgIFwic3RlYW0tc3F1YXJlXCI6IFwiZjFiN1wiLFxuICAgIFwicmVjeWNsZVwiOiBcImYxYjhcIixcbiAgICBcImF1dG9tb2JpbGUsY2FyXCI6IFwiZjFiOVwiLFxuICAgIFwiY2FiLHRheGlcIjogXCJmMWJhXCIsXG4gICAgXCJ0cmVlXCI6IFwiZjFiYlwiLFxuICAgIFwic3BvdGlmeVwiOiBcImYxYmNcIixcbiAgICBcImRldmlhbnRhcnRcIjogXCJmMWJkXCIsXG4gICAgXCJzb3VuZGNsb3VkXCI6IFwiZjFiZVwiLFxuICAgIFwiZGF0YWJhc2VcIjogXCJmMWMwXCIsXG4gICAgXCJmaWxlLXBkZi1vXCI6IFwiZjFjMVwiLFxuICAgIFwiZmlsZS13b3JkLW9cIjogXCJmMWMyXCIsXG4gICAgXCJmaWxlLWV4Y2VsLW9cIjogXCJmMWMzXCIsXG4gICAgXCJmaWxlLXBvd2VycG9pbnQtb1wiOiBcImYxYzRcIixcbiAgICBcImZpbGUtcGhvdG8tbyxmaWxlLXBpY3R1cmUtbyxmaWxlLWltYWdlLW9cIjogXCJmMWM1XCIsXG4gICAgXCJmaWxlLXppcC1vLGZpbGUtYXJjaGl2ZS1vXCI6IFwiZjFjNlwiLFxuICAgIFwiZmlsZS1zb3VuZC1vLGZpbGUtYXVkaW8tb1wiOiBcImYxYzdcIixcbiAgICBcImZpbGUtbW92aWUtbyxmaWxlLXZpZGVvLW9cIjogXCJmMWM4XCIsXG4gICAgXCJmaWxlLWNvZGUtb1wiOiBcImYxYzlcIixcbiAgICBcInZpbmVcIjogXCJmMWNhXCIsXG4gICAgXCJjb2RlcGVuXCI6IFwiZjFjYlwiLFxuICAgIFwianNmaWRkbGVcIjogXCJmMWNjXCIsXG4gICAgXCJsaWZlLWJvdXksbGlmZS1idW95LGxpZmUtc2F2ZXIsc3VwcG9ydCxsaWZlLXJpbmdcIjogXCJmMWNkXCIsXG4gICAgXCJjaXJjbGUtby1ub3RjaFwiOiBcImYxY2VcIixcbiAgICBcInJhLHJlc2lzdGFuY2UscmViZWxcIjogXCJmMWQwXCIsXG4gICAgXCJnZSxlbXBpcmVcIjogXCJmMWQxXCIsXG4gICAgXCJnaXQtc3F1YXJlXCI6IFwiZjFkMlwiLFxuICAgIFwiZ2l0XCI6IFwiZjFkM1wiLFxuICAgIFwieS1jb21iaW5hdG9yLXNxdWFyZSx5Yy1zcXVhcmUsaGFja2VyLW5ld3NcIjogXCJmMWQ0XCIsXG4gICAgXCJ0ZW5jZW50LXdlaWJvXCI6IFwiZjFkNVwiLFxuICAgIFwicXFcIjogXCJmMWQ2XCIsXG4gICAgXCJ3ZWNoYXQsd2VpeGluXCI6IFwiZjFkN1wiLFxuICAgIFwic2VuZCxwYXBlci1wbGFuZVwiOiBcImYxZDhcIixcbiAgICBcInNlbmQtbyxwYXBlci1wbGFuZS1vXCI6IFwiZjFkOVwiLFxuICAgIFwiaGlzdG9yeVwiOiBcImYxZGFcIixcbiAgICBcImNpcmNsZS10aGluXCI6IFwiZjFkYlwiLFxuICAgIFwiaGVhZGVyXCI6IFwiZjFkY1wiLFxuICAgIFwicGFyYWdyYXBoXCI6IFwiZjFkZFwiLFxuICAgIFwic2xpZGVyc1wiOiBcImYxZGVcIixcbiAgICBcInNoYXJlLWFsdFwiOiBcImYxZTBcIixcbiAgICBcInNoYXJlLWFsdC1zcXVhcmVcIjogXCJmMWUxXCIsXG4gICAgXCJib21iXCI6IFwiZjFlMlwiLFxuICAgIFwic29jY2VyLWJhbGwtbyxmdXRib2wtb1wiOiBcImYxZTNcIixcbiAgICBcInR0eVwiOiBcImYxZTRcIixcbiAgICBcImJpbm9jdWxhcnNcIjogXCJmMWU1XCIsXG4gICAgXCJwbHVnXCI6IFwiZjFlNlwiLFxuICAgIFwic2xpZGVzaGFyZVwiOiBcImYxZTdcIixcbiAgICBcInR3aXRjaFwiOiBcImYxZThcIixcbiAgICBcInllbHBcIjogXCJmMWU5XCIsXG4gICAgXCJuZXdzcGFwZXItb1wiOiBcImYxZWFcIixcbiAgICBcIndpZmlcIjogXCJmMWViXCIsXG4gICAgXCJjYWxjdWxhdG9yXCI6IFwiZjFlY1wiLFxuICAgIFwicGF5cGFsXCI6IFwiZjFlZFwiLFxuICAgIFwiZ29vZ2xlLXdhbGxldFwiOiBcImYxZWVcIixcbiAgICBcImNjLXZpc2FcIjogXCJmMWYwXCIsXG4gICAgXCJjYy1tYXN0ZXJjYXJkXCI6IFwiZjFmMVwiLFxuICAgIFwiY2MtZGlzY292ZXJcIjogXCJmMWYyXCIsXG4gICAgXCJjYy1hbWV4XCI6IFwiZjFmM1wiLFxuICAgIFwiY2MtcGF5cGFsXCI6IFwiZjFmNFwiLFxuICAgIFwiY2Mtc3RyaXBlXCI6IFwiZjFmNVwiLFxuICAgIFwiYmVsbC1zbGFzaFwiOiBcImYxZjZcIixcbiAgICBcImJlbGwtc2xhc2gtb1wiOiBcImYxZjdcIixcbiAgICBcInRyYXNoXCI6IFwiZjFmOFwiLFxuICAgIFwiY29weXJpZ2h0XCI6IFwiZjFmOVwiLFxuICAgIFwiYXRcIjogXCJmMWZhXCIsXG4gICAgXCJleWVkcm9wcGVyXCI6IFwiZjFmYlwiLFxuICAgIFwicGFpbnQtYnJ1c2hcIjogXCJmMWZjXCIsXG4gICAgXCJiaXJ0aGRheS1jYWtlXCI6IFwiZjFmZFwiLFxuICAgIFwiYXJlYS1jaGFydFwiOiBcImYxZmVcIixcbiAgICBcInBpZS1jaGFydFwiOiBcImYyMDBcIixcbiAgICBcImxpbmUtY2hhcnRcIjogXCJmMjAxXCIsXG4gICAgXCJsYXN0Zm1cIjogXCJmMjAyXCIsXG4gICAgXCJsYXN0Zm0tc3F1YXJlXCI6IFwiZjIwM1wiLFxuICAgIFwidG9nZ2xlLW9mZlwiOiBcImYyMDRcIixcbiAgICBcInRvZ2dsZS1vblwiOiBcImYyMDVcIixcbiAgICBcImJpY3ljbGVcIjogXCJmMjA2XCIsXG4gICAgXCJidXNcIjogXCJmMjA3XCIsXG4gICAgXCJpb3hob3N0XCI6IFwiZjIwOFwiLFxuICAgIFwiYW5nZWxsaXN0XCI6IFwiZjIwOVwiLFxuICAgIFwiY2NcIjogXCJmMjBhXCIsXG4gICAgXCJzaGVrZWwsc2hlcWVsLGlsc1wiOiBcImYyMGJcIixcbiAgICBcIm1lYW5wYXRoXCI6IFwiZjIwY1wiLFxuICAgIFwiYnV5c2VsbGFkc1wiOiBcImYyMGRcIixcbiAgICBcImNvbm5lY3RkZXZlbG9wXCI6IFwiZjIwZVwiLFxuICAgIFwiZGFzaGN1YmVcIjogXCJmMjEwXCIsXG4gICAgXCJmb3J1bWJlZVwiOiBcImYyMTFcIixcbiAgICBcImxlYW5wdWJcIjogXCJmMjEyXCIsXG4gICAgXCJzZWxsc3lcIjogXCJmMjEzXCIsXG4gICAgXCJzaGlydHNpbmJ1bGtcIjogXCJmMjE0XCIsXG4gICAgXCJzaW1wbHlidWlsdFwiOiBcImYyMTVcIixcbiAgICBcInNreWF0bGFzXCI6IFwiZjIxNlwiLFxuICAgIFwiY2FydC1wbHVzXCI6IFwiZjIxN1wiLFxuICAgIFwiY2FydC1hcnJvdy1kb3duXCI6IFwiZjIxOFwiLFxuICAgIFwiZGlhbW9uZFwiOiBcImYyMTlcIixcbiAgICBcInNoaXBcIjogXCJmMjFhXCIsXG4gICAgXCJ1c2VyLXNlY3JldFwiOiBcImYyMWJcIixcbiAgICBcIm1vdG9yY3ljbGVcIjogXCJmMjFjXCIsXG4gICAgXCJzdHJlZXQtdmlld1wiOiBcImYyMWRcIixcbiAgICBcImhlYXJ0YmVhdFwiOiBcImYyMWVcIixcbiAgICBcInZlbnVzXCI6IFwiZjIyMVwiLFxuICAgIFwibWFyc1wiOiBcImYyMjJcIixcbiAgICBcIm1lcmN1cnlcIjogXCJmMjIzXCIsXG4gICAgXCJpbnRlcnNleCx0cmFuc2dlbmRlclwiOiBcImYyMjRcIixcbiAgICBcInRyYW5zZ2VuZGVyLWFsdFwiOiBcImYyMjVcIixcbiAgICBcInZlbnVzLWRvdWJsZVwiOiBcImYyMjZcIixcbiAgICBcIm1hcnMtZG91YmxlXCI6IFwiZjIyN1wiLFxuICAgIFwidmVudXMtbWFyc1wiOiBcImYyMjhcIixcbiAgICBcIm1hcnMtc3Ryb2tlXCI6IFwiZjIyOVwiLFxuICAgIFwibWFycy1zdHJva2UtdlwiOiBcImYyMmFcIixcbiAgICBcIm1hcnMtc3Ryb2tlLWhcIjogXCJmMjJiXCIsXG4gICAgXCJuZXV0ZXJcIjogXCJmMjJjXCIsXG4gICAgXCJnZW5kZXJsZXNzXCI6IFwiZjIyZFwiLFxuICAgIFwiZmFjZWJvb2stb2ZmaWNpYWxcIjogXCJmMjMwXCIsXG4gICAgXCJwaW50ZXJlc3QtcFwiOiBcImYyMzFcIixcbiAgICBcIndoYXRzYXBwXCI6IFwiZjIzMlwiLFxuICAgIFwic2VydmVyXCI6IFwiZjIzM1wiLFxuICAgIFwidXNlci1wbHVzXCI6IFwiZjIzNFwiLFxuICAgIFwidXNlci10aW1lc1wiOiBcImYyMzVcIixcbiAgICBcImhvdGVsLGJlZFwiOiBcImYyMzZcIixcbiAgICBcInZpYWNvaW5cIjogXCJmMjM3XCIsXG4gICAgXCJ0cmFpblwiOiBcImYyMzhcIixcbiAgICBcInN1YndheVwiOiBcImYyMzlcIixcbiAgICBcIm1lZGl1bVwiOiBcImYyM2FcIixcbiAgICBcInljLHktY29tYmluYXRvclwiOiBcImYyM2JcIixcbiAgICBcIm9wdGluLW1vbnN0ZXJcIjogXCJmMjNjXCIsXG4gICAgXCJvcGVuY2FydFwiOiBcImYyM2RcIixcbiAgICBcImV4cGVkaXRlZHNzbFwiOiBcImYyM2VcIixcbiAgICBcImJhdHRlcnktNCxiYXR0ZXJ5LWZ1bGxcIjogXCJmMjQwXCIsXG4gICAgXCJiYXR0ZXJ5LTMsYmF0dGVyeS10aHJlZS1xdWFydGVyc1wiOiBcImYyNDFcIixcbiAgICBcImJhdHRlcnktMixiYXR0ZXJ5LWhhbGZcIjogXCJmMjQyXCIsXG4gICAgXCJiYXR0ZXJ5LTEsYmF0dGVyeS1xdWFydGVyXCI6IFwiZjI0M1wiLFxuICAgIFwiYmF0dGVyeS0wLGJhdHRlcnktZW1wdHlcIjogXCJmMjQ0XCIsXG4gICAgXCJtb3VzZS1wb2ludGVyXCI6IFwiZjI0NVwiLFxuICAgIFwiaS1jdXJzb3JcIjogXCJmMjQ2XCIsXG4gICAgXCJvYmplY3QtZ3JvdXBcIjogXCJmMjQ3XCIsXG4gICAgXCJvYmplY3QtdW5ncm91cFwiOiBcImYyNDhcIixcbiAgICBcInN0aWNreS1ub3RlXCI6IFwiZjI0OVwiLFxuICAgIFwic3RpY2t5LW5vdGUtb1wiOiBcImYyNGFcIixcbiAgICBcImNjLWpjYlwiOiBcImYyNGJcIixcbiAgICBcImNjLWRpbmVycy1jbHViXCI6IFwiZjI0Y1wiLFxuICAgIFwiY2xvbmVcIjogXCJmMjRkXCIsXG4gICAgXCJiYWxhbmNlLXNjYWxlXCI6IFwiZjI0ZVwiLFxuICAgIFwiaG91cmdsYXNzLW9cIjogXCJmMjUwXCIsXG4gICAgXCJob3VyZ2xhc3MtMSxob3VyZ2xhc3Mtc3RhcnRcIjogXCJmMjUxXCIsXG4gICAgXCJob3VyZ2xhc3MtMixob3VyZ2xhc3MtaGFsZlwiOiBcImYyNTJcIixcbiAgICBcImhvdXJnbGFzcy0zLGhvdXJnbGFzcy1lbmRcIjogXCJmMjUzXCIsXG4gICAgXCJob3VyZ2xhc3NcIjogXCJmMjU0XCIsXG4gICAgXCJoYW5kLWdyYWItbyxoYW5kLXJvY2stb1wiOiBcImYyNTVcIixcbiAgICBcImhhbmQtc3RvcC1vLGhhbmQtcGFwZXItb1wiOiBcImYyNTZcIixcbiAgICBcImhhbmQtc2Npc3NvcnMtb1wiOiBcImYyNTdcIixcbiAgICBcImhhbmQtbGl6YXJkLW9cIjogXCJmMjU4XCIsXG4gICAgXCJoYW5kLXNwb2NrLW9cIjogXCJmMjU5XCIsXG4gICAgXCJoYW5kLXBvaW50ZXItb1wiOiBcImYyNWFcIixcbiAgICBcImhhbmQtcGVhY2Utb1wiOiBcImYyNWJcIixcbiAgICBcInRyYWRlbWFya1wiOiBcImYyNWNcIixcbiAgICBcInJlZ2lzdGVyZWRcIjogXCJmMjVkXCIsXG4gICAgXCJjcmVhdGl2ZS1jb21tb25zXCI6IFwiZjI1ZVwiLFxuICAgIFwiZ2dcIjogXCJmMjYwXCIsXG4gICAgXCJnZy1jaXJjbGVcIjogXCJmMjYxXCIsXG4gICAgXCJ0cmlwYWR2aXNvclwiOiBcImYyNjJcIixcbiAgICBcIm9kbm9rbGFzc25pa2lcIjogXCJmMjYzXCIsXG4gICAgXCJvZG5va2xhc3NuaWtpLXNxdWFyZVwiOiBcImYyNjRcIixcbiAgICBcImdldC1wb2NrZXRcIjogXCJmMjY1XCIsXG4gICAgXCJ3aWtpcGVkaWEtd1wiOiBcImYyNjZcIixcbiAgICBcInNhZmFyaVwiOiBcImYyNjdcIixcbiAgICBcImNocm9tZVwiOiBcImYyNjhcIixcbiAgICBcImZpcmVmb3hcIjogXCJmMjY5XCIsXG4gICAgXCJvcGVyYVwiOiBcImYyNmFcIixcbiAgICBcImludGVybmV0LWV4cGxvcmVyXCI6IFwiZjI2YlwiLFxuICAgIFwidHYsdGVsZXZpc2lvblwiOiBcImYyNmNcIixcbiAgICBcImNvbnRhb1wiOiBcImYyNmRcIixcbiAgICBcIjUwMHB4XCI6IFwiZjI2ZVwiLFxuICAgIFwiYW1hem9uXCI6IFwiZjI3MFwiLFxuICAgIFwiY2FsZW5kYXItcGx1cy1vXCI6IFwiZjI3MVwiLFxuICAgIFwiY2FsZW5kYXItbWludXMtb1wiOiBcImYyNzJcIixcbiAgICBcImNhbGVuZGFyLXRpbWVzLW9cIjogXCJmMjczXCIsXG4gICAgXCJjYWxlbmRhci1jaGVjay1vXCI6IFwiZjI3NFwiLFxuICAgIFwiaW5kdXN0cnlcIjogXCJmMjc1XCIsXG4gICAgXCJtYXAtcGluXCI6IFwiZjI3NlwiLFxuICAgIFwibWFwLXNpZ25zXCI6IFwiZjI3N1wiLFxuICAgIFwibWFwLW9cIjogXCJmMjc4XCIsXG4gICAgXCJtYXBcIjogXCJmMjc5XCIsXG4gICAgXCJjb21tZW50aW5nXCI6IFwiZjI3YVwiLFxuICAgIFwiY29tbWVudGluZy1vXCI6IFwiZjI3YlwiLFxuICAgIFwiaG91enpcIjogXCJmMjdjXCIsXG4gICAgXCJ2aW1lb1wiOiBcImYyN2RcIixcbiAgICBcImJsYWNrLXRpZVwiOiBcImYyN2VcIixcbiAgICBcImZvbnRpY29uc1wiOiBcImYyODBcIixcbiAgICBcInJlZGRpdC1hbGllblwiOiBcImYyODFcIixcbiAgICBcImVkZ2VcIjogXCJmMjgyXCIsXG4gICAgXCJjcmVkaXQtY2FyZC1hbHRcIjogXCJmMjgzXCIsXG4gICAgXCJjb2RpZXBpZVwiOiBcImYyODRcIixcbiAgICBcIm1vZHhcIjogXCJmMjg1XCIsXG4gICAgXCJmb3J0LWF3ZXNvbWVcIjogXCJmMjg2XCIsXG4gICAgXCJ1c2JcIjogXCJmMjg3XCIsXG4gICAgXCJwcm9kdWN0LWh1bnRcIjogXCJmMjg4XCIsXG4gICAgXCJtaXhjbG91ZFwiOiBcImYyODlcIixcbiAgICBcInNjcmliZFwiOiBcImYyOGFcIixcbiAgICBcInBhdXNlLWNpcmNsZVwiOiBcImYyOGJcIixcbiAgICBcInBhdXNlLWNpcmNsZS1vXCI6IFwiZjI4Y1wiLFxuICAgIFwic3RvcC1jaXJjbGVcIjogXCJmMjhkXCIsXG4gICAgXCJzdG9wLWNpcmNsZS1vXCI6IFwiZjI4ZVwiLFxuICAgIFwic2hvcHBpbmctYmFnXCI6IFwiZjI5MFwiLFxuICAgIFwic2hvcHBpbmctYmFza2V0XCI6IFwiZjI5MVwiLFxuICAgIFwiaGFzaHRhZ1wiOiBcImYyOTJcIixcbiAgICBcImJsdWV0b290aFwiOiBcImYyOTNcIixcbiAgICBcImJsdWV0b290aC1iXCI6IFwiZjI5NFwiLFxuICAgIFwicGVyY2VudFwiOiBcImYyOTVcIixcbiAgICBcImdpdGxhYlwiOiBcImYyOTZcIixcbiAgICBcIndwYmVnaW5uZXJcIjogXCJmMjk3XCIsXG4gICAgXCJ3cGZvcm1zXCI6IFwiZjI5OFwiLFxuICAgIFwiZW52aXJhXCI6IFwiZjI5OVwiLFxuICAgIFwidW5pdmVyc2FsLWFjY2Vzc1wiOiBcImYyOWFcIixcbiAgICBcIndoZWVsY2hhaXItYWx0XCI6IFwiZjI5YlwiLFxuICAgIFwicXVlc3Rpb24tY2lyY2xlLW9cIjogXCJmMjljXCIsXG4gICAgXCJibGluZFwiOiBcImYyOWRcIixcbiAgICBcImF1ZGlvLWRlc2NyaXB0aW9uXCI6IFwiZjI5ZVwiLFxuICAgIFwidm9sdW1lLWNvbnRyb2wtcGhvbmVcIjogXCJmMmEwXCIsXG4gICAgXCJicmFpbGxlXCI6IFwiZjJhMVwiLFxuICAgIFwiYXNzaXN0aXZlLWxpc3RlbmluZy1zeXN0ZW1zXCI6IFwiZjJhMlwiLFxuICAgIFwiYXNsLWludGVycHJldGluZyxhbWVyaWNhbi1zaWduLWxhbmd1YWdlLWludGVycHJldGluZ1wiOiBcImYyYTNcIixcbiAgICBcImRlYWZuZXNzLGhhcmQtb2YtaGVhcmluZyxkZWFmXCI6IFwiZjJhNFwiLFxuICAgIFwiZ2xpZGVcIjogXCJmMmE1XCIsXG4gICAgXCJnbGlkZS1nXCI6IFwiZjJhNlwiLFxuICAgIFwic2lnbmluZyxzaWduLWxhbmd1YWdlXCI6IFwiZjJhN1wiLFxuICAgIFwibG93LXZpc2lvblwiOiBcImYyYThcIixcbiAgICBcInZpYWRlb1wiOiBcImYyYTlcIixcbiAgICBcInZpYWRlby1zcXVhcmVcIjogXCJmMmFhXCIsXG4gICAgXCJzbmFwY2hhdFwiOiBcImYyYWJcIixcbiAgICBcInNuYXBjaGF0LWdob3N0XCI6IFwiZjJhY1wiLFxuICAgIFwic25hcGNoYXQtc3F1YXJlXCI6IFwiZjJhZFwiLFxuICAgIFwicGllZC1waXBlclwiOiBcImYyYWVcIixcbiAgICBcImZpcnN0LW9yZGVyXCI6IFwiZjJiMFwiLFxuICAgIFwieW9hc3RcIjogXCJmMmIxXCIsXG4gICAgXCJ0aGVtZWlzbGVcIjogXCJmMmIyXCIsXG4gICAgXCJnb29nbGUtcGx1cy1jaXJjbGUsZ29vZ2xlLXBsdXMtb2ZmaWNpYWxcIjogXCJmMmIzXCIsXG4gICAgXCJmYSxmb250LWF3ZXNvbWVcIjogXCJmMmI0XCJcbiAgfTtcbn1cblxudmFyIEZvbnRBd2Vzb21lID0ge1xuICBmb250QXdlc29tZUljb25zOiBmb250QXdlc29tZUljb25zXG59O1xuXG5tb2R1bGUuZXhwb3J0cyA9IEZvbnRBd2Vzb21lO1xuIiwiXG5mdW5jdGlvbiBhcHBlbmRJbmZvUGFuZWwoY29udGFpbmVyKSB7XG4gICAgcmV0dXJuIGNvbnRhaW5lci5hcHBlbmQoJ2RpdicpXG4gICAgICAuYXR0cignY2xhc3MnLCAnbmVvNGpkMy1pbmZvJyk7XG4gIH1cbiAgXG4gIGZ1bmN0aW9uIGFwcGVuZEluZm9FbGVtZW50KGNscywgaXNOb2RlLCBwcm9wZXJ0eSwgdmFsdWUpIHtcbiAgICB2YXIgZWxlbSA9IGluZm8uYXBwZW5kKCdhJyk7XG4gICAgXG4gICAgZWxlbS5hdHRyKCdocmVmJywgJyMnKVxuICAgICAgLmF0dHIoJ2NsYXNzJywgY2xzKVxuICAgICAgLmh0bWwoJzxzdHJvbmc+JyArIHByb3BlcnR5ICsgJzwvc3Ryb25nPicgKyAodmFsdWUgPyAoJzogJyArIHZhbHVlKSA6ICcnKSk7XG4gICAgXG4gICAgaWYgKCF2YWx1ZSkge1xuICAgICAgZWxlbS5zdHlsZSgnYmFja2dyb3VuZC1jb2xvcicsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgcmV0dXJuIG9wdGlvbnMubm9kZU91dGxpbmVGaWxsQ29sb3IgPyBvcHRpb25zLm5vZGVPdXRsaW5lRmlsbENvbG9yIDogKGlzTm9kZSA/IGNsYXNzMmNvbG9yKHByb3BlcnR5KSA6IGRlZmF1bHRDb2xvcigpKTtcbiAgICAgIH0pXG4gICAgICAgIC5zdHlsZSgnYm9yZGVyLWNvbG9yJywgZnVuY3Rpb24oZCkge1xuICAgICAgICAgIHJldHVybiBvcHRpb25zLm5vZGVPdXRsaW5lRmlsbENvbG9yID8gY2xhc3MyZGFya2VuQ29sb3Iob3B0aW9ucy5ub2RlT3V0bGluZUZpbGxDb2xvcikgOiAoaXNOb2RlID8gY2xhc3MyZGFya2VuQ29sb3IocHJvcGVydHkpIDogZGVmYXVsdERhcmtlbkNvbG9yKCkpO1xuICAgICAgICB9KVxuICAgICAgICAuc3R5bGUoJ2NvbG9yJywgZnVuY3Rpb24oZCkge1xuICAgICAgICAgIHJldHVybiBvcHRpb25zLm5vZGVPdXRsaW5lRmlsbENvbG9yID8gY2xhc3MyZGFya2VuQ29sb3Iob3B0aW9ucy5ub2RlT3V0bGluZUZpbGxDb2xvcikgOiAnI2ZmZic7XG4gICAgICAgIH0pO1xuICAgIH1cbiAgfVxuICBcbiAgZnVuY3Rpb24gYXBwZW5kSW5mb0VsZW1lbnRDbGFzcyhjbHMsIG5vZGUpIHtcbiAgICBhcHBlbmRJbmZvRWxlbWVudChjbHMsIHRydWUsIG5vZGUpO1xuICB9XG4gIFxuICBmdW5jdGlvbiBhcHBlbmRJbmZvRWxlbWVudFByb3BlcnR5KGNscywgcHJvcGVydHksIHZhbHVlKSB7XG4gICAgYXBwZW5kSW5mb0VsZW1lbnQoY2xzLCBmYWxzZSwgcHJvcGVydHksIHZhbHVlKTtcbiAgfVxuICBcbiAgZnVuY3Rpb24gYXBwZW5kSW5mb0VsZW1lbnRSZWxhdGlvbnNoaXAoY2xzLCByZWxhdGlvbnNoaXApIHtcbiAgICBhcHBlbmRJbmZvRWxlbWVudChjbHMsIGZhbHNlLCByZWxhdGlvbnNoaXApO1xuICB9XG5cbiAgZnVuY3Rpb24gdXBkYXRlSW5mbyhkKSB7XG4gICAgY2xlYXJJbmZvKCk7XG4gICAgXG4gICAgaWYgKGQubGFiZWxzKSB7XG4gICAgICBhcHBlbmRJbmZvRWxlbWVudENsYXNzKCdjbGFzcycsIGQubGFiZWxzWzBdKTtcbiAgICB9IGVsc2Uge1xuICAgICAgYXBwZW5kSW5mb0VsZW1lbnRSZWxhdGlvbnNoaXAoJ2NsYXNzJywgZC50eXBlKTtcbiAgICB9XG4gICAgXG4gICAgYXBwZW5kSW5mb0VsZW1lbnRQcm9wZXJ0eSgncHJvcGVydHknLCAnJmx0O2lkJmd0OycsIGQuaWQpO1xuICAgIFxuICAgIE9iamVjdC5rZXlzKGQucHJvcGVydGllcykuZm9yRWFjaChmdW5jdGlvbihwcm9wZXJ0eSkge1xuICAgICAgYXBwZW5kSW5mb0VsZW1lbnRQcm9wZXJ0eSgncHJvcGVydHknLCBwcm9wZXJ0eSwgSlNPTi5zdHJpbmdpZnkoZC5wcm9wZXJ0aWVzW3Byb3BlcnR5XSkpO1xuICAgIH0pO1xuICB9XG5cbiAgdmFyIEluZm9CYXIgPSB7XG5cbiAgICAgIGFwcGVuZEluZm9QYW5lbDogYXBwZW5kSW5mb1BhbmVsLFxuICAgICAgYXBwZW5kSW5mb0VsZW1lbnQ6IGFwcGVuZEluZm9FbGVtZW50LFxuICAgICAgYXBwZW5kSW5mb0VsZW1lbnRDbGFzczogYXBwZW5kSW5mb0VsZW1lbnRDbGFzcyxcbiAgICAgIGFwcGVuZEluZm9FbGVtZW50UHJvcGVydHk6IGFwcGVuZEluZm9FbGVtZW50UHJvcGVydHksXG4gICAgICBhcHBlbmRJbmZvRWxlbWVudFJlbGF0aW9uc2hpcDogYXBwZW5kSW5mb0VsZW1lbnRSZWxhdGlvbnNoaXAsXG4gICAgICB1cGRhdGVJbmZvOiB1cGRhdGVJbmZvXG4gIH1cblxubW9kdWxlLmV4cG9ydHMgPSBJbmZvQmFyOyIsIi8qIGdsb2JhbCBkMywgZG9jdW1lbnQgKi9cbi8qIGpzaGludCBsYXRlZGVmOm5vZnVuYyAqL1xuJ3VzZSBzdHJpY3QnO1xudmFyIEluZm9QYW5lbCA9IHJlcXVpcmUoXCIuL2luZm9iYXIuanNcIik7XG52YXIgRm9udEF3ZXNvbWUgPSByZXF1aXJlKFwiLi9mb250YXdlc29tZS5qc1wiKTtcblxuZnVuY3Rpb24gTmVvNGpEMyhfc2VsZWN0b3IsIF9vcHRpb25zKSB7XG4gIHZhciBjb250YWluZXIsIGdyYXBoLCBpbmZvLCBub2RlLCBub2RlcywgcmVsYXRpb25zaGlwLCByZWxhdGlvbnNoaXBPdXRsaW5lLCByZWxhdGlvbnNoaXBPdmVybGF5LCByZWxhdGlvbnNoaXBUZXh0LCByZWxhdGlvbnNoaXBzLCBzZWxlY3Rvciwgc2ltdWxhdGlvbiwgc3ZnLCBzdmdOb2Rlcywgc3ZnUmVsYXRpb25zaGlwcywgc3ZnU2NhbGUsIHN2Z1RyYW5zbGF0ZSxcbiAgICBjbGFzc2VzMmNvbG9ycyA9IHt9LFxuICAgIGp1c3RMb2FkZWQgPSBmYWxzZSxcbiAgICBudW1DbGFzc2VzID0gMCxcbiAgICBvcHRpb25zID0ge1xuICAgICAgYXJyb3dTaXplOiA0LFxuICAgICAgY29sb3JzOiBjb2xvcnMoKSxcbiAgICAgIGhpZ2hsaWdodDogdW5kZWZpbmVkLFxuICAgICAgaWNvbk1hcDogRm9udEF3ZXNvbWUuZm9udEF3ZXNvbWVJY29ucygpLFxuICAgICAgaWNvbnM6IHVuZGVmaW5lZCxcbiAgICAgIGltYWdlTWFwOiB7fSxcbiAgICAgIGltYWdlczogdW5kZWZpbmVkLFxuICAgICAgaW5mb1BhbmVsOiB0cnVlLFxuICAgICAgbWluQ29sbGlzaW9uOiB1bmRlZmluZWQsXG4gICAgICBuZW80akRhdGE6IHVuZGVmaW5lZCxcbiAgICAgIG5lbzRqRGF0YVVybDogdW5kZWZpbmVkLFxuICAgICAgbm9kZU91dGxpbmVGaWxsQ29sb3I6IHVuZGVmaW5lZCxcbiAgICAgIG5vZGVSYWRpdXM6IDI1LFxuICAgICAgcmVsYXRpb25zaGlwQ29sb3I6ICcjYTVhYmI2JyxcbiAgICAgIHpvb21GaXQ6IGZhbHNlXG4gICAgfSxcbiAgICBWRVJTSU9OID0gJzAuMC4yJztcblxuICBmdW5jdGlvbiBhcHBlbmRHcmFwaChjb250YWluZXIpIHtcbiAgICBzdmcgPSBjb250YWluZXIuYXBwZW5kKCdzdmcnKVxuICAgICAgLmF0dHIoJ3dpZHRoJywgJzEwMCUnKVxuICAgICAgLmF0dHIoJ2hlaWdodCcsICcxMDAlJylcbiAgICAgIC5hdHRyKCdjbGFzcycsICduZW80amQzLWdyYXBoJylcbiAgICAgIC5jYWxsKGQzLnpvb20oKS5vbignem9vbScsIGZ1bmN0aW9uKCkge1xuICAgICAgICB2YXIgc2NhbGUgPSBkMy5ldmVudC50cmFuc2Zvcm0uayxcbiAgICAgICAgICB0cmFuc2xhdGUgPSBbZDMuZXZlbnQudHJhbnNmb3JtLngsIGQzLmV2ZW50LnRyYW5zZm9ybS55XTtcblxuICAgICAgICBpZiAoc3ZnVHJhbnNsYXRlKSB7XG4gICAgICAgICAgdHJhbnNsYXRlWzBdICs9IHN2Z1RyYW5zbGF0ZVswXTtcbiAgICAgICAgICB0cmFuc2xhdGVbMV0gKz0gc3ZnVHJhbnNsYXRlWzFdO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKHN2Z1NjYWxlKSB7XG4gICAgICAgICAgc2NhbGUgKj0gc3ZnU2NhbGU7XG4gICAgICAgIH1cblxuICAgICAgICBzdmcuYXR0cigndHJhbnNmb3JtJywgJ3RyYW5zbGF0ZSgnICsgdHJhbnNsYXRlWzBdICsgJywgJyArIHRyYW5zbGF0ZVsxXSArICcpIHNjYWxlKCcgKyBzY2FsZSArICcpJyk7XG4gICAgICB9KSlcbiAgICAgIC5vbignZGJsY2xpY2suem9vbScsIG51bGwpXG4gICAgICAuYXBwZW5kKCdnJylcbiAgICAgIC5hdHRyKCd3aWR0aCcsICcxMDAlJylcbiAgICAgIC5hdHRyKCdoZWlnaHQnLCAnMTAwJScpO1xuXG4gICAgc3ZnUmVsYXRpb25zaGlwcyA9IHN2Zy5hcHBlbmQoJ2cnKVxuICAgICAgLmF0dHIoJ2NsYXNzJywgJ3JlbGF0aW9uc2hpcHMnKTtcblxuICAgIHN2Z05vZGVzID0gc3ZnLmFwcGVuZCgnZycpXG4gICAgICAuYXR0cignY2xhc3MnLCAnbm9kZXMnKTtcbiAgfVxuXG4gIGZ1bmN0aW9uIGFwcGVuZEltYWdlVG9Ob2RlKG5vZGUpIHtcbiAgICByZXR1cm4gbm9kZS5hcHBlbmQoJ2ltYWdlJylcbiAgICAgIC5hdHRyKCdoZWlnaHQnLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBpY29uKGQpID8gJzI0cHgnOiAnMzBweCc7XG4gICAgICB9KVxuICAgICAgLmF0dHIoJ3gnLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBpY29uKGQpID8gJzVweCc6ICctMTVweCc7XG4gICAgICB9KVxuICAgICAgLmF0dHIoJ3hsaW5rOmhyZWYnLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBpbWFnZShkKTtcbiAgICAgIH0pXG4gICAgICAuYXR0cigneScsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgcmV0dXJuIGljb24oZCkgPyAnNXB4JzogJy0xNnB4JztcbiAgICAgIH0pXG4gICAgICAuYXR0cignd2lkdGgnLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBpY29uKGQpID8gJzI0cHgnOiAnMzBweCc7XG4gICAgICB9KTtcbiAgfVxuXG4gIGZ1bmN0aW9uIGFwcGVuZE5vZGUoKSB7XG4gICAgcmV0dXJuIG5vZGUuZW50ZXIoKVxuICAgICAgLmFwcGVuZCgnZycpXG4gICAgICAuYXR0cignY2xhc3MnLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHZhciBoaWdobGlnaHQsIGksXG4gICAgICAgICAgY2xhc3NlcyA9ICdub2RlJyxcbiAgICAgICAgICBsYWJlbCA9IGQubGFiZWw7XG5cbiAgICAgICAgaWYgKGljb24oZCkpIHtcbiAgICAgICAgICBjbGFzc2VzICs9ICcgbm9kZS1pY29uJztcbiAgICAgICAgfVxuXG4gICAgICAgIGlmIChpbWFnZShkKSkge1xuICAgICAgICAgIGNsYXNzZXMgKz0gJyBub2RlLWltYWdlJztcbiAgICAgICAgfVxuXG4gICAgICAgIGlmIChvcHRpb25zLmhpZ2hsaWdodCkge1xuICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBvcHRpb25zLmhpZ2hsaWdodC5sZW5ndGg7IGkrKykge1xuICAgICAgICAgICAgaGlnaGxpZ2h0ID0gb3B0aW9ucy5oaWdobGlnaHRbaV07XG5cbiAgICAgICAgICAgIGlmIChkLmxhYmVsID09PSBoaWdobGlnaHQuY2xhc3MgJiYgZC5wcm9wZXJ0aWVzW2hpZ2hsaWdodC5wcm9wZXJ0eV0gPT09IGhpZ2hsaWdodC52YWx1ZSkge1xuICAgICAgICAgICAgICBjbGFzc2VzICs9ICcgbm9kZS1oaWdobGlnaHRlZCc7XG4gICAgICAgICAgICAgIGJyZWFrO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfVxuXG4gICAgICAgIHJldHVybiBjbGFzc2VzO1xuICAgICAgfSlcbiAgICAgIC5vbignY2xpY2snLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIGQuZnggPSBkLmZ5ID0gbnVsbDtcblxuICAgICAgICBpZiAodHlwZW9mIG9wdGlvbnMub25Ob2RlQ2xpY2sgPT09ICdmdW5jdGlvbicpIHtcbiAgICAgICAgICBvcHRpb25zLm9uTm9kZUNsaWNrKGQpO1xuICAgICAgICB9XG4gICAgICB9KVxuICAgICAgLm9uKCdkYmxjbGljaycsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgc3RpY2tOb2RlKGQpO1xuXG4gICAgICAgIGlmICh0eXBlb2Ygb3B0aW9ucy5vbk5vZGVEb3VibGVDbGljayA9PT0gJ2Z1bmN0aW9uJykge1xuICAgICAgICAgIG9wdGlvbnMub25Ob2RlRG91YmxlQ2xpY2soZCk7XG4gICAgICAgIH1cbiAgICAgIH0pXG4gICAgICAub24oJ21vdXNlZW50ZXInLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIGlmIChpbmZvKSB7XG4gICAgICAgICAgSW5mb1BhbmVsLnVwZGF0ZUluZm8oZCk7XG4gICAgICAgIH1cblxuICAgICAgICBpZiAodHlwZW9mIG9wdGlvbnMub25Ob2RlTW91c2VFbnRlciA9PT0gJ2Z1bmN0aW9uJykge1xuICAgICAgICAgIG9wdGlvbnMub25Ob2RlTW91c2VFbnRlcihkKTtcbiAgICAgICAgfVxuICAgICAgfSlcbiAgICAgIC5vbignbW91c2VsZWF2ZScsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgaWYgKGluZm8pIHtcbiAgICAgICAgICBJbmZvUGFuZWwuY2xlYXJJbmZvKGQpO1xuICAgICAgICB9XG5cbiAgICAgICAgaWYgKHR5cGVvZiBvcHRpb25zLm9uTm9kZU1vdXNlTGVhdmUgPT09ICdmdW5jdGlvbicpIHtcbiAgICAgICAgICBvcHRpb25zLm9uTm9kZU1vdXNlTGVhdmUoZCk7XG4gICAgICAgIH1cbiAgICAgIH0pXG4gICAgICAuY2FsbChkMy5kcmFnKClcbiAgICAgICAgLm9uKCdzdGFydCcsIGRyYWdTdGFydGVkKVxuICAgICAgICAub24oJ2RyYWcnLCBkcmFnZ2VkKVxuICAgICAgICAub24oJ2VuZCcsIGRyYWdFbmRlZCkpO1xuICB9XG5cbiAgZnVuY3Rpb24gYXBwZW5kTm9kZVRvR3JhcGgoKSB7XG4gICAgdmFyIG4gPSBhcHBlbmROb2RlKCk7XG5cbiAgICBhcHBlbmRSaW5nVG9Ob2RlKG4pO1xuICAgIGFwcGVuZE91dGxpbmVUb05vZGUobik7XG5cbiAgICBpZiAob3B0aW9ucy5pY29ucykge1xuICAgICAgYXBwZW5kVGV4dFRvTm9kZShuKTtcbiAgICB9XG5cbiAgICBpZiAob3B0aW9ucy5pbWFnZXMpIHtcbiAgICAgIGFwcGVuZEltYWdlVG9Ob2RlKG4pO1xuICAgIH1cblxuICAgIHJldHVybiBuO1xuICB9XG5cbiAgZnVuY3Rpb24gYXBwZW5kT3V0bGluZVRvTm9kZShub2RlKSB7XG4gICAgcmV0dXJuIG5vZGUuYXBwZW5kKCdjaXJjbGUnKVxuICAgICAgLmF0dHIoJ2NsYXNzJywgJ291dGxpbmUnKVxuICAgICAgLmF0dHIoJ3InLCBvcHRpb25zLm5vZGVSYWRpdXMpXG4gICAgICAuc3R5bGUoJ2ZpbGwnLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBvcHRpb25zLm5vZGVPdXRsaW5lRmlsbENvbG9yID8gb3B0aW9ucy5ub2RlT3V0bGluZUZpbGxDb2xvciA6IGNsYXNzMmNvbG9yKGQubGFiZWwpO1xuICAgICAgfSlcbiAgICAgIC5zdHlsZSgnc3Ryb2tlJywgZnVuY3Rpb24oZCkge1xuICAgICAgICByZXR1cm4gb3B0aW9ucy5ub2RlT3V0bGluZUZpbGxDb2xvciA/IGNsYXNzMmRhcmtlbkNvbG9yKG9wdGlvbnMubm9kZU91dGxpbmVGaWxsQ29sb3IpIDogY2xhc3MyZGFya2VuQ29sb3IoZC5sYWJlbCk7XG4gICAgICB9KVxuICAgICAgLmFwcGVuZCgndGl0bGUnKS50ZXh0KGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgcmV0dXJuIHRvU3RyaW5nKGQpO1xuICAgICAgfSk7XG4gIH1cblxuICBmdW5jdGlvbiBhcHBlbmRSaW5nVG9Ob2RlKG5vZGUpIHtcbiAgICByZXR1cm4gbm9kZS5hcHBlbmQoJ2NpcmNsZScpXG4gICAgICAuYXR0cignY2xhc3MnLCAncmluZycpXG4gICAgICAuYXR0cigncicsIG9wdGlvbnMubm9kZVJhZGl1cyAqIDEuMTYpXG4gICAgICAuYXBwZW5kKCd0aXRsZScpLnRleHQoZnVuY3Rpb24oZCkge1xuXG4gICAgICAgIHJldHVybiB0b1N0cmluZyhkKTtcbiAgICAgIH0pO1xuICB9XG5cbiAgZnVuY3Rpb24gYXBwZW5kVGV4dFRvTm9kZShub2RlKSB7XG4gICAgcmV0dXJuIG5vZGUuYXBwZW5kKCd0ZXh0JylcbiAgICAgIC5hdHRyKCdjbGFzcycsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgcmV0dXJuICd0ZXh0JyArIChpY29uKGQpID8gJyBpY29uJyA6ICcnKTtcbiAgICAgIH0pXG4gICAgICAuYXR0cignZmlsbCcsICcjZmZmZmZmJylcbiAgICAgIC5hdHRyKCdmb250LXNpemUnLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBpY29uKGQpID8gKG9wdGlvbnMubm9kZVJhZGl1cyArICdweCcpIDogJzEwcHgnO1xuICAgICAgfSlcbiAgICAgIC5hdHRyKCdwb2ludGVyLWV2ZW50cycsICdub25lJylcbiAgICAgIC5hdHRyKCd0ZXh0LWFuY2hvcicsICdtaWRkbGUnKVxuICAgICAgLmF0dHIoJ3knLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBpY29uKGQpID8gKHBhcnNlSW50KE1hdGgucm91bmQob3B0aW9ucy5ub2RlUmFkaXVzICogMC4zMikpICsgJ3B4JykgOiAnNHB4JztcbiAgICAgIH0pXG4gICAgICAuaHRtbChmdW5jdGlvbihkKSB7XG4gICAgICAgIHZhciBfaWNvbiA9IGljb24oZCk7XG4gICAgICAgIHJldHVybiBfaWNvbiA/ICcmI3gnICsgX2ljb24gOiBkLmxhYmVsO1xuICAgICAgfSk7XG4gIH1cblxuICBmdW5jdGlvbiBhcHBlbmRSZWxhdGlvbnNoaXAoKSB7XG4gICAgcmV0dXJuIHJlbGF0aW9uc2hpcC5lbnRlcigpXG4gICAgICAuYXBwZW5kKCdnJylcbiAgICAgIC5hdHRyKCdjbGFzcycsICdyZWxhdGlvbnNoaXAnKVxuICAgICAgLm9uKCdkYmxjbGljaycsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgaWYgKHR5cGVvZiBvcHRpb25zLm9uUmVsYXRpb25zaGlwRG91YmxlQ2xpY2sgPT09ICdmdW5jdGlvbicpIHtcbiAgICAgICAgICBvcHRpb25zLm9uUmVsYXRpb25zaGlwRG91YmxlQ2xpY2soZCk7XG4gICAgICAgIH1cbiAgICAgIH0pXG4gICAgICAub24oJ21vdXNlZW50ZXInLCBmdW5jdGlvbihkKSB7XG4gICAgICAgIGlmIChpbmZvKSB7XG4gICAgICAgICAgSW5mb1BhbmVsLnVwZGF0ZUluZm8oZCk7XG4gICAgICAgIH1cbiAgICAgIH0pO1xuICB9XG5cbiAgZnVuY3Rpb24gYXBwZW5kT3V0bGluZVRvUmVsYXRpb25zaGlwKHIpIHtcbiAgICByZXR1cm4gci5hcHBlbmQoJ3BhdGgnKVxuICAgICAgLmF0dHIoJ2NsYXNzJywgJ291dGxpbmUnKVxuICAgICAgLmF0dHIoJ2ZpbGwnLCAnI2E1YWJiNicpXG4gICAgICAuYXR0cignc3Ryb2tlJywgJ25vbmUnKTtcbiAgfVxuXG4gIGZ1bmN0aW9uIGFwcGVuZE92ZXJsYXlUb1JlbGF0aW9uc2hpcChyKSB7XG4gICAgcmV0dXJuIHIuYXBwZW5kKCdwYXRoJylcbiAgICAgIC5hdHRyKCdjbGFzcycsICdvdmVybGF5Jyk7XG4gIH1cblxuICBmdW5jdGlvbiBhcHBlbmRUZXh0VG9SZWxhdGlvbnNoaXAocikge1xuICAgIHJldHVybiByLmFwcGVuZCgndGV4dCcpXG4gICAgICAuYXR0cignY2xhc3MnLCAndGV4dCcpXG4gICAgICAuYXR0cignZmlsbCcsICcjMDAwMDAwJylcbiAgICAgIC5hdHRyKCdmb250LXNpemUnLCAnOHB4JylcbiAgICAgIC5hdHRyKCdwb2ludGVyLWV2ZW50cycsICdub25lJylcbiAgICAgIC5hdHRyKCd0ZXh0LWFuY2hvcicsICdtaWRkbGUnKVxuICAgICAgLnRleHQoZnVuY3Rpb24oZCkge1xuICAgICAgICByZXR1cm4gZC50eXBlO1xuICAgICAgfSk7XG4gIH1cblxuICBmdW5jdGlvbiBhcHBlbmRSZWxhdGlvbnNoaXBUb0dyYXBoKCkge1xuICAgIHZhciByZWxhdGlvbnNoaXAgPSBhcHBlbmRSZWxhdGlvbnNoaXAoKSxcbiAgICAgIHRleHQgPSBhcHBlbmRUZXh0VG9SZWxhdGlvbnNoaXAocmVsYXRpb25zaGlwKSxcbiAgICAgIG91dGxpbmUgPSBhcHBlbmRPdXRsaW5lVG9SZWxhdGlvbnNoaXAocmVsYXRpb25zaGlwKSxcbiAgICAgIG92ZXJsYXkgPSBhcHBlbmRPdmVybGF5VG9SZWxhdGlvbnNoaXAocmVsYXRpb25zaGlwKTtcblxuICAgIHJldHVybiB7XG4gICAgICBvdXRsaW5lOiBvdXRsaW5lLFxuICAgICAgb3ZlcmxheTogb3ZlcmxheSxcbiAgICAgIHJlbGF0aW9uc2hpcDogcmVsYXRpb25zaGlwLFxuICAgICAgdGV4dDogdGV4dFxuICAgIH07XG4gIH1cblxuICBmdW5jdGlvbiBjbGFzczJjb2xvcihjbHMpIHtcbiAgICB2YXIgY29sb3IgPSBjbGFzc2VzMmNvbG9yc1tjbHNdO1xuXG4gICAgaWYgKCFjb2xvcikge1xuICAgICAgLy8gICAgICAgICAgICBjb2xvciA9IG9wdGlvbnMuY29sb3JzW01hdGgubWluKG51bUNsYXNzZXMsIG9wdGlvbnMuY29sb3JzLmxlbmd0aCAtIDEpXTtcbiAgICAgIGNvbG9yID0gb3B0aW9ucy5jb2xvcnNbbnVtQ2xhc3NlcyAlIG9wdGlvbnMuY29sb3JzLmxlbmd0aF07XG4gICAgICBjbGFzc2VzMmNvbG9yc1tjbHNdID0gY29sb3I7XG4gICAgICBudW1DbGFzc2VzKys7XG4gICAgfVxuXG4gICAgcmV0dXJuIGNvbG9yO1xuICB9XG5cbiAgZnVuY3Rpb24gY2xhc3MyZGFya2VuQ29sb3IoY2xzKSB7XG4gICAgcmV0dXJuIGQzLnJnYihjbGFzczJjb2xvcihjbHMpKS5kYXJrZXIoMSk7XG4gIH1cblxuICBmdW5jdGlvbiBjbGVhckluZm8oKSB7XG4gICAgaW5mby5odG1sKCcnKTtcbiAgfVxuXG4gIGZ1bmN0aW9uIGNvbG9yKCkge1xuICAgIHJldHVybiBvcHRpb25zLmNvbG9yc1tvcHRpb25zLmNvbG9ycy5sZW5ndGggKiBNYXRoLnJhbmRvbSgpIDw8IDBdO1xuICB9XG5cbiAgZnVuY3Rpb24gY29sb3JzKCkge1xuICAgIC8vIGQzLnNjaGVtZUNhdGVnb3J5MTAsXG4gICAgLy8gZDMuc2NoZW1lQ2F0ZWdvcnkyMCxcbiAgICByZXR1cm4gW1xuICAgICAgJyM2OGJkZjYnLCAvLyBsaWdodCBibHVlXG4gICAgICAnIzZkY2U5ZScsIC8vIGdyZWVuICMxXG4gICAgICAnI2ZhYWZjMicsIC8vIGxpZ2h0IHBpbmtcbiAgICAgICcjZjJiYWY2JywgLy8gcHVycGxlXG4gICAgICAnI2ZmOTI4YycsIC8vIGxpZ2h0IHJlZFxuICAgICAgJyNmY2VhN2UnLCAvLyBsaWdodCB5ZWxsb3dcbiAgICAgICcjZmZjNzY2JywgLy8gbGlnaHQgb3JhbmdlXG4gICAgICAnIzQwNWY5ZScsIC8vIG5hdnkgYmx1ZVxuICAgICAgJyNhNWFiYjYnLCAvLyBkYXJrIGdyYXlcbiAgICAgICcjNzhjZWNiJywgLy8gZ3JlZW4gIzIsXG4gICAgICAnI2I4OGNiYicsIC8vIGRhcmsgcHVycGxlXG4gICAgICAnI2NlZDJkOScsIC8vIGxpZ2h0IGdyYXlcbiAgICAgICcjZTg0NjQ2JywgLy8gZGFyayByZWRcbiAgICAgICcjZmE1Zjg2JywgLy8gZGFyayBwaW5rXG4gICAgICAnI2ZmYWIxYScsIC8vIGRhcmsgb3JhbmdlXG4gICAgICAnI2ZjZGExOScsIC8vIGRhcmsgeWVsbG93XG4gICAgICAnIzc5N2I4MCcsIC8vIGJsYWNrXG4gICAgICAnI2M5ZDk2ZicsIC8vIHBpc3RhY2NoaW9cbiAgICAgICcjNDc5OTFmJywgLy8gZ3JlZW4gIzNcbiAgICAgICcjNzBlZGVlJywgLy8gdHVycXVvaXNlXG4gICAgICAnI2ZmNzVlYScgIC8vIHBpbmtcbiAgICBdO1xuICB9XG5cbiAgZnVuY3Rpb24gY29udGFpbnMoYXJyYXksIGlkKSB7XG4gICAgdmFyIGZpbHRlciA9IGFycmF5LmZpbHRlcihmdW5jdGlvbihlbGVtKSB7XG4gICAgICByZXR1cm4gZWxlbS5pZCA9PT0gaWQ7XG4gICAgfSk7XG5cbiAgICByZXR1cm4gZmlsdGVyLmxlbmd0aCA+IDA7XG4gIH1cblxuICBmdW5jdGlvbiBkZWZhdWx0Q29sb3IoKSB7XG4gICAgcmV0dXJuIG9wdGlvbnMucmVsYXRpb25zaGlwQ29sb3I7XG4gIH1cblxuICBmdW5jdGlvbiBkZWZhdWx0RGFya2VuQ29sb3IoKSB7XG4gICAgcmV0dXJuIGQzLnJnYihvcHRpb25zLmNvbG9yc1tvcHRpb25zLmNvbG9ycy5sZW5ndGggLSAxXSkuZGFya2VyKDEpO1xuICB9XG5cbiAgZnVuY3Rpb24gZHJhZ0VuZGVkKGQpIHtcbiAgICBpZiAoIWQzLmV2ZW50LmFjdGl2ZSkge1xuICAgICAgc2ltdWxhdGlvbi5hbHBoYVRhcmdldCgwKTtcbiAgICB9XG5cbiAgICBpZiAodHlwZW9mIG9wdGlvbnMub25Ob2RlRHJhZ0VuZCA9PT0gJ2Z1bmN0aW9uJykge1xuICAgICAgb3B0aW9ucy5vbk5vZGVEcmFnRW5kKGQpO1xuICAgIH1cbiAgfVxuXG4gIGZ1bmN0aW9uIGRyYWdnZWQoZCkge1xuICAgIHN0aWNrTm9kZShkKTtcbiAgfVxuXG4gIGZ1bmN0aW9uIGRyYWdTdGFydGVkKGQpIHtcbiAgICBpZiAoIWQzLmV2ZW50LmFjdGl2ZSkgeyBcbiAgICAgIHNpbXVsYXRpb24uYWxwaGFUYXJnZXQoMC4zKS5yZXN0YXJ0KCk7XG4gICAgfVxuXG4gICAgZC5meCA9IGQueDtcbiAgICBkLmZ5ID0gZC55O1xuXG4gICAgaWYgKHR5cGVvZiBvcHRpb25zLm9uTm9kZURyYWdTdGFydCA9PT0gJ2Z1bmN0aW9uJykge1xuICAgICAgb3B0aW9ucy5vbk5vZGVEcmFnU3RhcnQoZCk7XG4gICAgfVxuICB9XG5cbiAgZnVuY3Rpb24gZXh0ZW5kKG9iajEsIG9iajIpIHtcbiAgICB2YXIgb2JqID0ge307XG5cbiAgICBtZXJnZShvYmosIG9iajEpO1xuICAgIG1lcmdlKG9iaiwgb2JqMik7XG5cbiAgICByZXR1cm4gb2JqO1xuICB9XG5cblxuICBmdW5jdGlvbiBpY29uKGQpIHtcbiAgICB2YXIgY29kZTtcblxuICAgIGlmIChvcHRpb25zLmljb25NYXAgJiYgb3B0aW9ucy5zaG93SWNvbnMgJiYgb3B0aW9ucy5pY29ucykge1xuICAgICAgaWYgKG9wdGlvbnMuaWNvbnNbZC5sYWJlbF0gJiYgb3B0aW9ucy5pY29uTWFwW29wdGlvbnMuaWNvbnNbZC5sYWJlbF1dKSB7XG4gICAgICAgIGNvZGUgPSBvcHRpb25zLmljb25NYXBbb3B0aW9ucy5pY29uc1tkLmxhYmVsXV07XG4gICAgICB9IGVsc2UgaWYgKG9wdGlvbnMuaWNvbk1hcFtkLmxhYmVsXSkge1xuICAgICAgICBjb2RlID0gb3B0aW9ucy5pY29uTWFwW2QubGFiZWxdO1xuICAgICAgfSBlbHNlIGlmIChvcHRpb25zLmljb25zW2QubGFiZWxdKSB7XG4gICAgICAgIGNvZGUgPSBvcHRpb25zLmljb25zW2QubGFiZWxdO1xuICAgICAgfVxuICAgIH1cblxuICAgIHJldHVybiBjb2RlO1xuICB9XG5cbiAgZnVuY3Rpb24gaW1hZ2UoZCkge1xuICAgIHZhciBpLCBpbWFnZXNGb3JMYWJlbCwgaW1nLCBpbWdMZXZlbCwgbGFiZWwsIGxhYmVsUHJvcGVydHlWYWx1ZSwgcHJvcGVydHksIHZhbHVlO1xuXG4gICAgaWYgKG9wdGlvbnMuaW1hZ2VzKSB7XG4gICAgICBpbWFnZXNGb3JMYWJlbCA9IG9wdGlvbnMuaW1hZ2VNYXBbZC5sYWJlbF07XG5cbiAgICAgIGlmIChpbWFnZXNGb3JMYWJlbCkge1xuICAgICAgICBpbWdMZXZlbCA9IDA7XG5cbiAgICAgICAgZm9yIChpID0gMDsgaSA8IGltYWdlc0ZvckxhYmVsLmxlbmd0aDsgaSsrKSB7XG4gICAgICAgICAgbGFiZWxQcm9wZXJ0eVZhbHVlID0gaW1hZ2VzRm9yTGFiZWxbaV0uc3BsaXQoJ3wnKTtcblxuICAgICAgICAgIHN3aXRjaCAobGFiZWxQcm9wZXJ0eVZhbHVlLmxlbmd0aCkge1xuICAgICAgICAgICAgY2FzZSAzOlxuICAgICAgICAgICAgICB2YWx1ZSA9IGxhYmVsUHJvcGVydHlWYWx1ZVsyXTtcbiAgICAgICAgICAgICAgLyogZmFsbHMgdGhyb3VnaCAqL1xuICAgICAgICAgICAgY2FzZSAyOlxuICAgICAgICAgICAgICBwcm9wZXJ0eSA9IGxhYmVsUHJvcGVydHlWYWx1ZVsxXTtcbiAgICAgICAgICAgICAgLyogZmFsbHMgdGhyb3VnaCAqL1xuICAgICAgICAgICAgY2FzZSAxOlxuICAgICAgICAgICAgICBsYWJlbCA9IGxhYmVsUHJvcGVydHlWYWx1ZVswXTtcbiAgICAgICAgICB9XG5cbiAgICAgICAgICBpZiAoZC5sYWJlbCA9PT0gbGFiZWwgJiZcbiAgICAgICAgICAgICghcHJvcGVydHkgfHwgZC5wcm9wZXJ0aWVzW3Byb3BlcnR5XSAhPT0gdW5kZWZpbmVkKSAmJlxuICAgICAgICAgICAgKCF2YWx1ZSB8fCBkLnByb3BlcnRpZXNbcHJvcGVydHldID09PSB2YWx1ZSkpIHtcbiAgICAgICAgICAgIGlmIChsYWJlbFByb3BlcnR5VmFsdWUubGVuZ3RoID4gaW1nTGV2ZWwpIHtcbiAgICAgICAgICAgICAgaW1nID0gb3B0aW9ucy5pbWFnZXNbaW1hZ2VzRm9yTGFiZWxbaV1dO1xuICAgICAgICAgICAgICBpbWdMZXZlbCA9IGxhYmVsUHJvcGVydHlWYWx1ZS5sZW5ndGg7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICB9XG4gICAgfVxuXG4gICAgcmV0dXJuIGltZztcbiAgfVxuXG4gIGZ1bmN0aW9uIGluaXQoX3NlbGVjdG9yLCBfb3B0aW9ucykge1xuXG4gICAgaW5pdEljb25NYXAoKTtcblxuICAgIG1lcmdlKG9wdGlvbnMsIF9vcHRpb25zKTtcblxuICAgIGlmIChvcHRpb25zLmljb25zKSB7XG4gICAgICBvcHRpb25zLnNob3dJY29ucyA9IHRydWU7XG4gICAgfVxuXG4gICAgaWYgKCFvcHRpb25zLm1pbkNvbGxpc2lvbikge1xuICAgICAgb3B0aW9ucy5taW5Db2xsaXNpb24gPSBvcHRpb25zLm5vZGVSYWRpdXMgKiAyO1xuICAgIH1cblxuICAgIGluaXRJbWFnZU1hcCgpO1xuXG4gICAgc2VsZWN0b3IgPSBfc2VsZWN0b3I7XG5cbiAgICBjb250YWluZXIgPSBkMy5zZWxlY3Qoc2VsZWN0b3IpO1xuXG4gICAgY29udGFpbmVyLmF0dHIoJ2NsYXNzJywgJ25lbzRqZDMnKVxuICAgICAgLmh0bWwoJycpO1xuXG4gICAgaWYgKG9wdGlvbnMuaW5mb1BhbmVsKSB7XG4gICAgICBpbmZvID0gSW5mb1BhbmVsLmFwcGVuZEluZm9QYW5lbChjb250YWluZXIpO1xuICAgIH1cblxuICAgIGFwcGVuZEdyYXBoKGNvbnRhaW5lcik7XG5cbiAgICBzaW11bGF0aW9uID0gaW5pdFNpbXVsYXRpb24oKTtcblxuICAgaWYgKG9wdGlvbnMubmVvNGpEYXRhKSB7XG4gICAgbG9hZE5lbzRqRGF0YShvcHRpb25zLm5lbzRqRGF0YSk7XG4gIH0gZWxzZSBpZiAob3B0aW9ucy5uZW80akRhdGFVcmwpIHtcbiAgICAgIGxvYWROZW80akRhdGFGcm9tVXJsKG9wdGlvbnMubmVvNGpEYXRhVXJsKTtcbiAgICB9IGVsc2Uge1xuICAgICAgY29uc29sZS5lcnJvcignRXJyb3I6IGJvdGggbmVvNGpEYXRhIGFuZCBuZW80akRhdGFVcmwgYXJlIGVtcHR5IScpO1xuICAgIH1cbiAgfVxuXG4gIGZ1bmN0aW9uIGluaXRJY29uTWFwKCkge1xuICAgIE9iamVjdC5rZXlzKG9wdGlvbnMuaWNvbk1hcCkuZm9yRWFjaChmdW5jdGlvbihrZXksIGluZGV4KSB7XG4gICAgICB2YXIga2V5cyA9IGtleS5zcGxpdCgnLCcpLFxuICAgICAgICB2YWx1ZSA9IG9wdGlvbnMuaWNvbk1hcFtrZXldO1xuXG4gICAgICBrZXlzLmZvckVhY2goZnVuY3Rpb24oa2V5KSB7XG4gICAgICAgIG9wdGlvbnMuaWNvbk1hcFtrZXldID0gdmFsdWU7XG4gICAgICB9KTtcbiAgICB9KTtcbiAgfVxuXG4gIGZ1bmN0aW9uIGluaXRJbWFnZU1hcCgpIHtcbiAgICB2YXIga2V5LCBrZXlzLCBzZWxlY3RvcjtcblxuICAgIGZvciAoa2V5IGluIG9wdGlvbnMuaW1hZ2VzKSB7XG4gICAgICBpZiAob3B0aW9ucy5pbWFnZXMuaGFzT3duUHJvcGVydHkoa2V5KSkge1xuICAgICAgICBrZXlzID0ga2V5LnNwbGl0KCd8Jyk7XG5cbiAgICAgICAgaWYgKCFvcHRpb25zLmltYWdlTWFwW2tleXNbMF1dKSB7XG4gICAgICAgICAgb3B0aW9ucy5pbWFnZU1hcFtrZXlzWzBdXSA9IFtrZXldO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIG9wdGlvbnMuaW1hZ2VNYXBba2V5c1swXV0ucHVzaChrZXkpO1xuICAgICAgICB9XG4gICAgICB9XG4gICAgfVxuICB9XG5cbiAgZnVuY3Rpb24gaW5pdFNpbXVsYXRpb24oKSB7XG4gICAgdmFyIHNpbXVsYXRpb24gPSBkMy5mb3JjZVNpbXVsYXRpb24oKVxuICAgIC8vICAgICAgICAgICAgICAgICAgICAgICAgICAgLnZlbG9jaXR5RGVjYXkoMC44KVxuICAgIC8vICAgICAgICAgICAgICAgICAgICAgICAgICAgLmZvcmNlKCd4JywgZDMuZm9yY2UoKS5zdHJlbmd0aCgwLjAwMikpXG4gICAgLy8gICAgICAgICAgICAgICAgICAgICAgICAgICAuZm9yY2UoJ3knLCBkMy5mb3JjZSgpLnN0cmVuZ3RoKDAuMDAyKSlcbiAgICAgIC5mb3JjZSgnY29sbGlkZScsIGQzLmZvcmNlQ29sbGlkZSgpLnJhZGl1cyhmdW5jdGlvbihkKSB7XG4gICAgICAgIHJldHVybiBvcHRpb25zLm1pbkNvbGxpc2lvbjtcbiAgICAgIH0pLml0ZXJhdGlvbnMoMikpXG4gICAgICAuZm9yY2UoJ2NoYXJnZScsIGQzLmZvcmNlTWFueUJvZHkoKSlcbiAgICAgIC5mb3JjZSgnbGluaycsIGQzLmZvcmNlTGluaygpLmlkKGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgcmV0dXJuIGQuaWQ7XG4gICAgICB9KSlcbiAgICAgIC5mb3JjZSgnY2VudGVyJywgZDMuZm9yY2VDZW50ZXIoc3ZnLm5vZGUoKS5wYXJlbnRFbGVtZW50LnBhcmVudEVsZW1lbnQuY2xpZW50V2lkdGggLyAyLCBzdmcubm9kZSgpLnBhcmVudEVsZW1lbnQucGFyZW50RWxlbWVudC5jbGllbnRIZWlnaHQgLyAyKSlcbiAgICAgIC5vbigndGljaycsIGZ1bmN0aW9uKCkge1xuICAgICAgICB0aWNrKCk7XG4gICAgICB9KVxuICAgICAgLm9uKCdlbmQnLCBmdW5jdGlvbigpIHtcbiAgICAgICAgaWYgKG9wdGlvbnMuem9vbUZpdCAmJiAhanVzdExvYWRlZCkge1xuICAgICAgICAgIGp1c3RMb2FkZWQgPSB0cnVlO1xuICAgICAgICAgIHpvb21GaXQoMik7XG4gICAgICAgIH1cbiAgICAgIH0pO1xuXG4gICAgcmV0dXJuIHNpbXVsYXRpb247XG4gIH1cblxuICBmdW5jdGlvbiBsb2FkTmVvNGpEYXRhKCkge1xuICAgIG5vZGVzID0gW107XG4gICAgcmVsYXRpb25zaGlwcyA9IFtdO1xuXG4gICAgdXBkYXRlV2l0aE5lbzRqRGF0YShvcHRpb25zLm5lbzRqRGF0YSk7XG4gIH1cblxuICBmdW5jdGlvbiBsb2FkTmVvNGpEYXRhRnJvbVVybChuZW80akRhdGFVcmwpIHtcbiAgICBub2RlcyA9IFtdO1xuICAgIHJlbGF0aW9uc2hpcHMgPSBbXTtcblxuICAgIGQzLmpzb24obmVvNGpEYXRhVXJsLCBmdW5jdGlvbihlcnJvciwgZGF0YSkge1xuXG4gICAgICB1cGRhdGVXaXRoTmVvNGpEYXRhKGRhdGEpO1xuICAgIH0pO1xuICB9XG5cbiAgZnVuY3Rpb24gbWVyZ2UodGFyZ2V0LCBzb3VyY2UpIHtcbiAgICBPYmplY3Qua2V5cyhzb3VyY2UpLmZvckVhY2goZnVuY3Rpb24ocHJvcGVydHkpIHtcbiAgICAgIHRhcmdldFtwcm9wZXJ0eV0gPSBzb3VyY2VbcHJvcGVydHldO1xuICAgIH0pO1xuICB9XG5cbiAgZnVuY3Rpb24gbmVvNGpEYXRhVG9EM0RhdGEoZGF0YSkge1xuICAgIHZhciBncmFwaCA9IHtcbiAgICAgIG5vZGVzOiBkYXRhLm5vZGVzLFxuICAgICAgcmVsYXRpb25zaGlwczogZGF0YS5saW5rc1xuICAgIH07XG5cbiAgICByZXR1cm4gZ3JhcGg7XG4gIH1cblxuICBmdW5jdGlvbiByb3RhdGUoY3gsIGN5LCB4LCB5LCBhbmdsZSkge1xuICAgIHZhciByYWRpYW5zID0gKE1hdGguUEkgLyAxODApICogYW5nbGUsXG4gICAgICBjb3MgPSBNYXRoLmNvcyhyYWRpYW5zKSxcbiAgICAgIHNpbiA9IE1hdGguc2luKHJhZGlhbnMpLFxuICAgICAgbnggPSAoY29zICogKHggLSBjeCkpICsgKHNpbiAqICh5IC0gY3kpKSArIGN4LFxuICAgICAgbnkgPSAoY29zICogKHkgLSBjeSkpIC0gKHNpbiAqICh4IC0gY3gpKSArIGN5O1xuXG4gICAgcmV0dXJuIHsgeDogbngsIHk6IG55IH07XG4gIH1cblxuICBmdW5jdGlvbiByb3RhdGVQb2ludChjLCBwLCBhbmdsZSkge1xuICAgIHJldHVybiByb3RhdGUoYy54LCBjLnksIHAueCwgcC55LCBhbmdsZSk7XG4gIH1cblxuICBmdW5jdGlvbiByb3RhdGlvbihzb3VyY2UsIHRhcmdldCkge1xuICAgIHJldHVybiBNYXRoLmF0YW4yKHRhcmdldC55IC0gc291cmNlLnksIHRhcmdldC54IC0gc291cmNlLngpICogMTgwIC8gTWF0aC5QSTtcbiAgfVxuXG4gIGZ1bmN0aW9uIHNpemUoKSB7XG4gICAgcmV0dXJuIHtcbiAgICAgIG5vZGVzOiBub2Rlcy5sZW5ndGgsXG4gICAgICByZWxhdGlvbnNoaXBzOiByZWxhdGlvbnNoaXBzLmxlbmd0aFxuICAgIH07XG4gIH1cblxuICBmdW5jdGlvbiBzdGlja05vZGUoZCkge1xuICAgIGQuZnggPSBkMy5ldmVudC54O1xuICAgIGQuZnkgPSBkMy5ldmVudC55O1xuICB9XG5cbiAgZnVuY3Rpb24gdGljaygpIHtcbiAgICB0aWNrTm9kZXMoKTtcbiAgICB0aWNrUmVsYXRpb25zaGlwcygpO1xuICB9XG5cbiAgZnVuY3Rpb24gdGlja05vZGVzKCkge1xuICAgIGlmIChub2RlKSB7XG4gICAgICBub2RlLmF0dHIoJ3RyYW5zZm9ybScsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgcmV0dXJuICd0cmFuc2xhdGUoJyArIGQueCArICcsICcgKyBkLnkgKyAnKSc7XG4gICAgICB9KTtcbiAgICB9XG4gIH1cblxuICBmdW5jdGlvbiB0aWNrUmVsYXRpb25zaGlwcygpIHtcbiAgICBpZiAocmVsYXRpb25zaGlwKSB7XG4gICAgICByZWxhdGlvbnNoaXAuYXR0cigndHJhbnNmb3JtJywgZnVuY3Rpb24oZCkge1xuICAgICAgICB2YXIgYW5nbGUgPSByb3RhdGlvbihkLnNvdXJjZSwgZC50YXJnZXQpO1xuICAgICAgICByZXR1cm4gJ3RyYW5zbGF0ZSgnICsgZC5zb3VyY2UueCArICcsICcgKyBkLnNvdXJjZS55ICsgJykgcm90YXRlKCcgKyBhbmdsZSArICcpJztcbiAgICAgIH0pO1xuXG4gICAgICB0aWNrUmVsYXRpb25zaGlwc1RleHRzKCk7XG4gICAgICB0aWNrUmVsYXRpb25zaGlwc091dGxpbmVzKCk7XG4gICAgICB0aWNrUmVsYXRpb25zaGlwc092ZXJsYXlzKCk7XG4gICAgfVxuICB9XG5cbiAgZnVuY3Rpb24gdGlja1JlbGF0aW9uc2hpcHNPdXRsaW5lcygpIHtcbiAgICByZWxhdGlvbnNoaXAuZWFjaChmdW5jdGlvbihyZWxhdGlvbnNoaXApIHtcbiAgICAgIHZhciByZWwgPSBkMy5zZWxlY3QodGhpcyksXG4gICAgICAgIG91dGxpbmUgPSByZWwuc2VsZWN0KCcub3V0bGluZScpLFxuICAgICAgICB0ZXh0ID0gcmVsLnNlbGVjdCgnLnRleHQnKSxcbiAgICAgICAgYmJveCA9IHRleHQubm9kZSgpLmdldEJCb3goKSxcbiAgICAgICAgcGFkZGluZyA9IDM7XG5cbiAgICAgIG91dGxpbmUuYXR0cignZCcsIGZ1bmN0aW9uKGQpIHtcbiAgICAgICAgdmFyIGNlbnRlciA9IHsgeDogMCwgeTogMCB9LFxuICAgICAgICAgIGFuZ2xlID0gcm90YXRpb24oZC5zb3VyY2UsIGQudGFyZ2V0KSxcbiAgICAgICAgICB0ZXh0Qm91bmRpbmdCb3ggPSB0ZXh0Lm5vZGUoKS5nZXRCQm94KCksXG4gICAgICAgICAgdGV4dFBhZGRpbmcgPSA1LFxuICAgICAgICAgIHUgPSB1bml0YXJ5VmVjdG9yKGQuc291cmNlLCBkLnRhcmdldCksXG4gICAgICAgICAgdGV4dE1hcmdpbiA9IHsgeDogKGQudGFyZ2V0LnggLSBkLnNvdXJjZS54IC0gKHRleHRCb3VuZGluZ0JveC53aWR0aCArIHRleHRQYWRkaW5nKSAqIHUueCkgKiAwLjUsIHk6IChkLnRhcmdldC55IC0gZC5zb3VyY2UueSAtICh0ZXh0Qm91bmRpbmdCb3gud2lkdGggKyB0ZXh0UGFkZGluZykgKiB1LnkpICogMC41IH0sXG4gICAgICAgICAgbiA9IHVuaXRhcnlOb3JtYWxWZWN0b3IoZC5zb3VyY2UsIGQudGFyZ2V0KSxcbiAgICAgICAgICByb3RhdGVkUG9pbnRBMSA9IHJvdGF0ZVBvaW50KGNlbnRlciwgeyB4OiAwICsgKG9wdGlvbnMubm9kZVJhZGl1cyArIDEpICogdS54IC0gbi54LCB5OiAwICsgKG9wdGlvbnMubm9kZVJhZGl1cyArIDEpICogdS55IC0gbi55IH0sIGFuZ2xlKSxcbiAgICAgICAgICByb3RhdGVkUG9pbnRCMSA9IHJvdGF0ZVBvaW50KGNlbnRlciwgeyB4OiB0ZXh0TWFyZ2luLnggLSBuLngsIHk6IHRleHRNYXJnaW4ueSAtIG4ueSB9LCBhbmdsZSksXG4gICAgICAgICAgcm90YXRlZFBvaW50QzEgPSByb3RhdGVQb2ludChjZW50ZXIsIHsgeDogdGV4dE1hcmdpbi54LCB5OiB0ZXh0TWFyZ2luLnkgfSwgYW5nbGUpLFxuICAgICAgICAgIHJvdGF0ZWRQb2ludEQxID0gcm90YXRlUG9pbnQoY2VudGVyLCB7IHg6IDAgKyAob3B0aW9ucy5ub2RlUmFkaXVzICsgMSkgKiB1LngsIHk6IDAgKyAob3B0aW9ucy5ub2RlUmFkaXVzICsgMSkgKiB1LnkgfSwgYW5nbGUpLFxuICAgICAgICAgIHJvdGF0ZWRQb2ludEEyID0gcm90YXRlUG9pbnQoY2VudGVyLCB7IHg6IGQudGFyZ2V0LnggLSBkLnNvdXJjZS54IC0gdGV4dE1hcmdpbi54IC0gbi54LCB5OiBkLnRhcmdldC55IC0gZC5zb3VyY2UueSAtIHRleHRNYXJnaW4ueSAtIG4ueSB9LCBhbmdsZSksXG4gICAgICAgICAgcm90YXRlZFBvaW50QjIgPSByb3RhdGVQb2ludChjZW50ZXIsIHsgeDogZC50YXJnZXQueCAtIGQuc291cmNlLnggLSAob3B0aW9ucy5ub2RlUmFkaXVzICsgMSkgKiB1LnggLSBuLnggLSB1LnggKiBvcHRpb25zLmFycm93U2l6ZSwgeTogZC50YXJnZXQueSAtIGQuc291cmNlLnkgLSAob3B0aW9ucy5ub2RlUmFkaXVzICsgMSkgKiB1LnkgLSBuLnkgLSB1LnkgKiBvcHRpb25zLmFycm93U2l6ZSB9LCBhbmdsZSksXG4gICAgICAgICAgcm90YXRlZFBvaW50QzIgPSByb3RhdGVQb2ludChjZW50ZXIsIHsgeDogZC50YXJnZXQueCAtIGQuc291cmNlLnggLSAob3B0aW9ucy5ub2RlUmFkaXVzICsgMSkgKiB1LnggLSBuLnggKyAobi54IC0gdS54KSAqIG9wdGlvbnMuYXJyb3dTaXplLCB5OiBkLnRhcmdldC55IC0gZC5zb3VyY2UueSAtIChvcHRpb25zLm5vZGVSYWRpdXMgKyAxKSAqIHUueSAtIG4ueSArIChuLnkgLSB1LnkpICogb3B0aW9ucy5hcnJvd1NpemUgfSwgYW5nbGUpLFxuICAgICAgICAgIHJvdGF0ZWRQb2ludEQyID0gcm90YXRlUG9pbnQoY2VudGVyLCB7IHg6IGQudGFyZ2V0LnggLSBkLnNvdXJjZS54IC0gKG9wdGlvbnMubm9kZVJhZGl1cyArIDEpICogdS54LCB5OiBkLnRhcmdldC55IC0gZC5zb3VyY2UueSAtIChvcHRpb25zLm5vZGVSYWRpdXMgKyAxKSAqIHUueSB9LCBhbmdsZSksXG4gICAgICAgICAgcm90YXRlZFBvaW50RTIgPSByb3RhdGVQb2ludChjZW50ZXIsIHsgeDogZC50YXJnZXQueCAtIGQuc291cmNlLnggLSAob3B0aW9ucy5ub2RlUmFkaXVzICsgMSkgKiB1LnggKyAoLSBuLnggLSB1LngpICogb3B0aW9ucy5hcnJvd1NpemUsIHk6IGQudGFyZ2V0LnkgLSBkLnNvdXJjZS55IC0gKG9wdGlvbnMubm9kZVJhZGl1cyArIDEpICogdS55ICsgKC0gbi55IC0gdS55KSAqIG9wdGlvbnMuYXJyb3dTaXplIH0sIGFuZ2xlKSxcbiAgICAgICAgICByb3RhdGVkUG9pbnRGMiA9IHJvdGF0ZVBvaW50KGNlbnRlciwgeyB4OiBkLnRhcmdldC54IC0gZC5zb3VyY2UueCAtIChvcHRpb25zLm5vZGVSYWRpdXMgKyAxKSAqIHUueCAtIHUueCAqIG9wdGlvbnMuYXJyb3dTaXplLCB5OiBkLnRhcmdldC55IC0gZC5zb3VyY2UueSAtIChvcHRpb25zLm5vZGVSYWRpdXMgKyAxKSAqIHUueSAtIHUueSAqIG9wdGlvbnMuYXJyb3dTaXplIH0sIGFuZ2xlKSxcbiAgICAgICAgICByb3RhdGVkUG9pbnRHMiA9IHJvdGF0ZVBvaW50KGNlbnRlciwgeyB4OiBkLnRhcmdldC54IC0gZC5zb3VyY2UueCAtIHRleHRNYXJnaW4ueCwgeTogZC50YXJnZXQueSAtIGQuc291cmNlLnkgLSB0ZXh0TWFyZ2luLnkgfSwgYW5nbGUpO1xuXG4gICAgICAgIHJldHVybiAnTSAnICsgcm90YXRlZFBvaW50QTEueCArICcgJyArIHJvdGF0ZWRQb2ludEExLnkgK1xuICAgICAgICAgICcgTCAnICsgcm90YXRlZFBvaW50QjEueCArICcgJyArIHJvdGF0ZWRQb2ludEIxLnkgK1xuICAgICAgICAgICcgTCAnICsgcm90YXRlZFBvaW50QzEueCArICcgJyArIHJvdGF0ZWRQb2ludEMxLnkgK1xuICAgICAgICAgICcgTCAnICsgcm90YXRlZFBvaW50RDEueCArICcgJyArIHJvdGF0ZWRQb2ludEQxLnkgK1xuICAgICAgICAgICcgWiBNICcgKyByb3RhdGVkUG9pbnRBMi54ICsgJyAnICsgcm90YXRlZFBvaW50QTIueSArXG4gICAgICAgICAgJyBMICcgKyByb3RhdGVkUG9pbnRCMi54ICsgJyAnICsgcm90YXRlZFBvaW50QjIueSArXG4gICAgICAgICAgJyBMICcgKyByb3RhdGVkUG9pbnRDMi54ICsgJyAnICsgcm90YXRlZFBvaW50QzIueSArXG4gICAgICAgICAgJyBMICcgKyByb3RhdGVkUG9pbnREMi54ICsgJyAnICsgcm90YXRlZFBvaW50RDIueSArXG4gICAgICAgICAgJyBMICcgKyByb3RhdGVkUG9pbnRFMi54ICsgJyAnICsgcm90YXRlZFBvaW50RTIueSArXG4gICAgICAgICAgJyBMICcgKyByb3RhdGVkUG9pbnRGMi54ICsgJyAnICsgcm90YXRlZFBvaW50RjIueSArXG4gICAgICAgICAgJyBMICcgKyByb3RhdGVkUG9pbnRHMi54ICsgJyAnICsgcm90YXRlZFBvaW50RzIueSArXG4gICAgICAgICAgJyBaJztcbiAgICAgIH0pO1xuICAgIH0pO1xuICB9XG5cbiAgZnVuY3Rpb24gdGlja1JlbGF0aW9uc2hpcHNPdmVybGF5cygpIHtcbiAgICByZWxhdGlvbnNoaXBPdmVybGF5LmF0dHIoJ2QnLCBmdW5jdGlvbihkKSB7XG4gICAgICB2YXIgY2VudGVyID0geyB4OiAwLCB5OiAwIH0sXG4gICAgICAgIGFuZ2xlID0gcm90YXRpb24oZC5zb3VyY2UsIGQudGFyZ2V0KSxcbiAgICAgICAgbjEgPSB1bml0YXJ5Tm9ybWFsVmVjdG9yKGQuc291cmNlLCBkLnRhcmdldCksXG4gICAgICAgIG4gPSB1bml0YXJ5Tm9ybWFsVmVjdG9yKGQuc291cmNlLCBkLnRhcmdldCwgNTApLFxuICAgICAgICByb3RhdGVkUG9pbnRBID0gcm90YXRlUG9pbnQoY2VudGVyLCB7IHg6IDAgLSBuLngsIHk6IDAgLSBuLnkgfSwgYW5nbGUpLFxuICAgICAgICByb3RhdGVkUG9pbnRCID0gcm90YXRlUG9pbnQoY2VudGVyLCB7IHg6IGQudGFyZ2V0LnggLSBkLnNvdXJjZS54IC0gbi54LCB5OiBkLnRhcmdldC55IC0gZC5zb3VyY2UueSAtIG4ueSB9LCBhbmdsZSksXG4gICAgICAgIHJvdGF0ZWRQb2ludEMgPSByb3RhdGVQb2ludChjZW50ZXIsIHsgeDogZC50YXJnZXQueCAtIGQuc291cmNlLnggKyBuLnggLSBuMS54LCB5OiBkLnRhcmdldC55IC0gZC5zb3VyY2UueSArIG4ueSAtIG4xLnkgfSwgYW5nbGUpLFxuICAgICAgICByb3RhdGVkUG9pbnREID0gcm90YXRlUG9pbnQoY2VudGVyLCB7IHg6IDAgKyBuLnggLSBuMS54LCB5OiAwICsgbi55IC0gbjEueSB9LCBhbmdsZSk7XG5cbiAgICAgIHJldHVybiAnTSAnICsgcm90YXRlZFBvaW50QS54ICsgJyAnICsgcm90YXRlZFBvaW50QS55ICtcbiAgICAgICAgJyBMICcgKyByb3RhdGVkUG9pbnRCLnggKyAnICcgKyByb3RhdGVkUG9pbnRCLnkgK1xuICAgICAgICAnIEwgJyArIHJvdGF0ZWRQb2ludEMueCArICcgJyArIHJvdGF0ZWRQb2ludEMueSArXG4gICAgICAgICcgTCAnICsgcm90YXRlZFBvaW50RC54ICsgJyAnICsgcm90YXRlZFBvaW50RC55ICtcbiAgICAgICAgJyBaJztcbiAgICB9KTtcbiAgfVxuXG4gIGZ1bmN0aW9uIHRpY2tSZWxhdGlvbnNoaXBzVGV4dHMoKSB7XG4gICAgcmVsYXRpb25zaGlwVGV4dC5hdHRyKCd0cmFuc2Zvcm0nLCBmdW5jdGlvbihkKSB7XG4gICAgICB2YXIgYW5nbGUgPSAocm90YXRpb24oZC5zb3VyY2UsIGQudGFyZ2V0KSArIDM2MCkgJSAzNjAsXG4gICAgICAgIG1pcnJvciA9IGFuZ2xlID4gOTAgJiYgYW5nbGUgPCAyNzAsXG4gICAgICAgIGNlbnRlciA9IHsgeDogMCwgeTogMCB9LFxuICAgICAgICBuID0gdW5pdGFyeU5vcm1hbFZlY3RvcihkLnNvdXJjZSwgZC50YXJnZXQpLFxuICAgICAgICBuV2VpZ2h0ID0gbWlycm9yID8gMiA6IC0zLFxuICAgICAgICBwb2ludCA9IHsgeDogKGQudGFyZ2V0LnggLSBkLnNvdXJjZS54KSAqIDAuNSArIG4ueCAqIG5XZWlnaHQsIHk6IChkLnRhcmdldC55IC0gZC5zb3VyY2UueSkgKiAwLjUgKyBuLnkgKiBuV2VpZ2h0IH0sXG4gICAgICAgIHJvdGF0ZWRQb2ludCA9IHJvdGF0ZVBvaW50KGNlbnRlciwgcG9pbnQsIGFuZ2xlKTtcblxuICAgICAgcmV0dXJuICd0cmFuc2xhdGUoJyArIHJvdGF0ZWRQb2ludC54ICsgJywgJyArIHJvdGF0ZWRQb2ludC55ICsgJykgcm90YXRlKCcgKyAobWlycm9yID8gMTgwIDogMCkgKyAnKSc7XG4gICAgfSk7XG4gIH1cblxuICBmdW5jdGlvbiB0b1N0cmluZyhkKSB7XG4gICAgdmFyIHMgPSBkLmxhYmVsID8gZC5sYWJlbCA6IGQudHlwZTtcblxuICAgIHMgKz0gJyAoPGlkPjogJyArIGQubGFiZWw7XG5cblxuICAgIHMgKz0gJyknO1xuXG4gICAgcmV0dXJuIHM7XG4gIH1cblxuICBmdW5jdGlvbiB1bml0YXJ5Tm9ybWFsVmVjdG9yKHNvdXJjZSwgdGFyZ2V0LCBuZXdMZW5ndGgpIHtcbiAgICB2YXIgY2VudGVyID0geyB4OiAwLCB5OiAwIH0sXG4gICAgICB2ZWN0b3IgPSB1bml0YXJ5VmVjdG9yKHNvdXJjZSwgdGFyZ2V0LCBuZXdMZW5ndGgpO1xuXG4gICAgcmV0dXJuIHJvdGF0ZVBvaW50KGNlbnRlciwgdmVjdG9yLCA5MCk7XG4gIH1cblxuICBmdW5jdGlvbiB1bml0YXJ5VmVjdG9yKHNvdXJjZSwgdGFyZ2V0LCBuZXdMZW5ndGgpIHtcbiAgICB2YXIgbGVuZ3RoID0gTWF0aC5zcXJ0KE1hdGgucG93KHRhcmdldC54IC0gc291cmNlLngsIDIpICsgTWF0aC5wb3codGFyZ2V0LnkgLSBzb3VyY2UueSwgMikpIC8gTWF0aC5zcXJ0KG5ld0xlbmd0aCB8fCAxKTtcblxuICAgIHJldHVybiB7XG4gICAgICB4OiAodGFyZ2V0LnggLSBzb3VyY2UueCkgLyBsZW5ndGgsXG4gICAgICB5OiAodGFyZ2V0LnkgLSBzb3VyY2UueSkgLyBsZW5ndGgsXG4gICAgfTtcbiAgfVxuXG4gIGZ1bmN0aW9uIHVwZGF0ZVdpdGhEM0RhdGEoZDNEYXRhKSB7XG4gICAgdXBkYXRlTm9kZXNBbmRSZWxhdGlvbnNoaXBzKGQzRGF0YS5ub2RlcywgZDNEYXRhLnJlbGF0aW9uc2hpcHMpO1xuICB9XG5cbiAgZnVuY3Rpb24gdXBkYXRlV2l0aE5lbzRqRGF0YShuZW80akRhdGEpIHtcbiAgICB2YXIgZDNEYXRhID0gbmVvNGpEYXRhVG9EM0RhdGEobmVvNGpEYXRhKTtcbiAgICB1cGRhdGVXaXRoRDNEYXRhKGQzRGF0YSk7XG4gIH1cblxuICBmdW5jdGlvbiB1cGRhdGVOb2RlcyhuKSB7XG4gICAgQXJyYXkucHJvdG90eXBlLnB1c2guYXBwbHkobm9kZXMsIG4pO1xuXG4gICAgbm9kZSA9IHN2Z05vZGVzLnNlbGVjdEFsbCgnLm5vZGUnKVxuICAgICAgLmRhdGEobm9kZXMsIGZ1bmN0aW9uKGQpIHsgcmV0dXJuIGQuaWQ7IH0pO1xuICAgIHZhciBub2RlRW50ZXIgPSBhcHBlbmROb2RlVG9HcmFwaCgpO1xuICAgIG5vZGUgPSBub2RlRW50ZXIubWVyZ2Uobm9kZSk7XG4gIH1cblxuICBmdW5jdGlvbiB1cGRhdGVOb2Rlc0FuZFJlbGF0aW9uc2hpcHMobiwgcikge1xuICAgIHVwZGF0ZVJlbGF0aW9uc2hpcHMocik7XG4gICAgdXBkYXRlTm9kZXMobik7XG5cbiAgICBzaW11bGF0aW9uLm5vZGVzKG5vZGVzKTtcbiAgICBzaW11bGF0aW9uLmZvcmNlKCdsaW5rJykubGlua3MocmVsYXRpb25zaGlwcyk7XG4gIH1cblxuICBmdW5jdGlvbiB1cGRhdGVSZWxhdGlvbnNoaXBzKHIpIHtcbiAgICBBcnJheS5wcm90b3R5cGUucHVzaC5hcHBseShyZWxhdGlvbnNoaXBzLCByKTtcblxuICAgIHJlbGF0aW9uc2hpcCA9IHN2Z1JlbGF0aW9uc2hpcHMuc2VsZWN0QWxsKCcucmVsYXRpb25zaGlwJylcbiAgICAvLyAuZGF0YShyZWxhdGlvbnNoaXBzLCBmdW5jdGlvbihkKSB7IHJldHVybiBkLmlkOyB9KTtcbiAgICAgIC5kYXRhKHJlbGF0aW9uc2hpcHMpO1xuXG4gICAgdmFyIHJlbGF0aW9uc2hpcEVudGVyID0gYXBwZW5kUmVsYXRpb25zaGlwVG9HcmFwaCgpO1xuXG4gICAgcmVsYXRpb25zaGlwID0gcmVsYXRpb25zaGlwRW50ZXIucmVsYXRpb25zaGlwLm1lcmdlKHJlbGF0aW9uc2hpcCk7XG5cbiAgICByZWxhdGlvbnNoaXBPdXRsaW5lID0gc3ZnLnNlbGVjdEFsbCgnLnJlbGF0aW9uc2hpcCAub3V0bGluZScpO1xuICAgIHJlbGF0aW9uc2hpcE91dGxpbmUgPSByZWxhdGlvbnNoaXBFbnRlci5vdXRsaW5lLm1lcmdlKHJlbGF0aW9uc2hpcE91dGxpbmUpO1xuXG4gICAgcmVsYXRpb25zaGlwT3ZlcmxheSA9IHN2Zy5zZWxlY3RBbGwoJy5yZWxhdGlvbnNoaXAgLm92ZXJsYXknKTtcbiAgICByZWxhdGlvbnNoaXBPdmVybGF5ID0gcmVsYXRpb25zaGlwRW50ZXIub3ZlcmxheS5tZXJnZShyZWxhdGlvbnNoaXBPdmVybGF5KTtcblxuICAgIHJlbGF0aW9uc2hpcFRleHQgPSBzdmcuc2VsZWN0QWxsKCcucmVsYXRpb25zaGlwIC50ZXh0Jyk7XG4gICAgcmVsYXRpb25zaGlwVGV4dCA9IHJlbGF0aW9uc2hpcEVudGVyLnRleHQubWVyZ2UocmVsYXRpb25zaGlwVGV4dCk7XG4gIH1cblxuICBmdW5jdGlvbiB2ZXJzaW9uKCkge1xuICAgIHJldHVybiBWRVJTSU9OO1xuICB9XG5cbiAgZnVuY3Rpb24gem9vbUZpdCh0cmFuc2l0aW9uRHVyYXRpb24pIHtcbiAgICB2YXIgYm91bmRzID0gc3ZnLm5vZGUoKS5nZXRCQm94KCksXG4gICAgICBwYXJlbnQgPSBzdmcubm9kZSgpLnBhcmVudEVsZW1lbnQucGFyZW50RWxlbWVudCxcbiAgICAgIGZ1bGxXaWR0aCA9IHBhcmVudC5jbGllbnRXaWR0aCxcbiAgICAgIGZ1bGxIZWlnaHQgPSBwYXJlbnQuY2xpZW50SGVpZ2h0LFxuICAgICAgd2lkdGggPSBib3VuZHMud2lkdGgsXG4gICAgICBoZWlnaHQgPSBib3VuZHMuaGVpZ2h0LFxuICAgICAgbWlkWCA9IGJvdW5kcy54ICsgd2lkdGggLyAyLFxuICAgICAgbWlkWSA9IGJvdW5kcy55ICsgaGVpZ2h0IC8gMjtcblxuICAgIGlmICh3aWR0aCA9PT0gMCB8fCBoZWlnaHQgPT09IDApIHtcbiAgICAgIHJldHVybjsgLy8gbm90aGluZyB0byBmaXRcbiAgICB9XG5cbiAgICBzdmdTY2FsZSA9IDAuODUgLyBNYXRoLm1heCh3aWR0aCAvIGZ1bGxXaWR0aCwgaGVpZ2h0IC8gZnVsbEhlaWdodCk7XG4gICAgc3ZnVHJhbnNsYXRlID0gW2Z1bGxXaWR0aCAvIDIgLSBzdmdTY2FsZSAqIG1pZFgsIGZ1bGxIZWlnaHQgLyAyIC0gc3ZnU2NhbGUgKiBtaWRZXTtcblxuICAgIHN2Zy5hdHRyKCd0cmFuc2Zvcm0nLCAndHJhbnNsYXRlKCcgKyBzdmdUcmFuc2xhdGVbMF0gKyAnLCAnICsgc3ZnVHJhbnNsYXRlWzFdICsgJykgc2NhbGUoJyArIHN2Z1NjYWxlICsgJyknKTtcbiAgICAvLyAgICAgICAgc21vb3RoVHJhbnNmb3JtKHN2Z1RyYW5zbGF0ZSwgc3ZnU2NhbGUpO1xuICB9XG5cbiAgaW5pdChfc2VsZWN0b3IsIF9vcHRpb25zKTtcblxuICByZXR1cm4ge1xuICAgIG5lbzRqRGF0YVRvRDNEYXRhOiBuZW80akRhdGFUb0QzRGF0YSxcbiAgICBzaXplOiBzaXplLFxuICAgIHVwZGF0ZVdpdGhEM0RhdGE6IHVwZGF0ZVdpdGhEM0RhdGEsXG4gICAgdXBkYXRlV2l0aE5lbzRqRGF0YTogdXBkYXRlV2l0aE5lbzRqRGF0YSxcbiAgICB2ZXJzaW9uOiB2ZXJzaW9uXG4gIH07XG59XG5cbm1vZHVsZS5leHBvcnRzID0gTmVvNGpEMztcbiJdfQ==
