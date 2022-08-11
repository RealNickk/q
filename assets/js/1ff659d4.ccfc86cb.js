"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[553],{3905:(e,t,n)=>{n.d(t,{Zo:()=>c,kt:()=>m});var a=n(67294);function o(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function i(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function r(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?i(Object(n),!0).forEach((function(t){o(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):i(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,a,o=function(e,t){if(null==e)return{};var n,a,o={},i=Object.keys(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||(o[n]=e[n]);return o}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var s=a.createContext({}),p=function(e){var t=a.useContext(s),n=t;return e&&(n="function"==typeof e?e(t):r(r({},t),e)),n},c=function(e){var t=p(e.components);return a.createElement(s.Provider,{value:t},e.children)},d={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},u=a.forwardRef((function(e,t){var n=e.components,o=e.mdxType,i=e.originalType,s=e.parentName,c=l(e,["components","mdxType","originalType","parentName"]),u=p(n),m=o,h=u["".concat(s,".").concat(m)]||u[m]||d[m]||i;return n?a.createElement(h,r(r({ref:t},c),{},{components:n})):a.createElement(h,r({ref:t},c))}));function m(e,t){var n=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var i=n.length,r=new Array(i);r[0]=u;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l.mdxType="string"==typeof e?e:o,r[1]=l;for(var p=2;p<i;p++)r[p]=n[p];return a.createElement.apply(null,r)}return a.createElement.apply(null,n)}u.displayName="MDXCreateElement"},57784:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>s,contentTitle:()=>r,default:()=>d,frontMatter:()=>i,metadata:()=>l,toc:()=>p});var a=n(87462),o=(n(67294),n(3905));const i={sidebar_position:3},r="Installation",l={unversionedId:"Installation",id:"Installation",title:"Installation",description:"q is a Lua module meant to be used in Roblox Luau and vanilla Lua. Because of",source:"@site/docs/Installation.md",sourceDirName:".",slug:"/Installation",permalink:"/q/docs/Installation",draft:!1,editUrl:"https://github.com/RealNickk/q/edit/master/docs/Installation.md",tags:[],version:"current",sidebarPosition:3,frontMatter:{sidebar_position:3},sidebar:"defaultSidebar",previous:{title:"Is q Something I Want to Use",permalink:"/q/docs/IsQSomethingIWantToUse"},next:{title:"The Basics of q",permalink:"/q/docs/basics"}},s={},p=[{value:"From the Repository",id:"from-the-repository",level:2},{value:"Roblox Environments",id:"roblox-environments",level:3},{value:"Vanilla Environments",id:"vanilla-environments",level:3},{value:"Exploit Environments",id:"exploit-environments",level:3},{value:"Using Loadstring",id:"using-loadstring",level:2},{value:"Exploit Environments",id:"exploit-environments-1",level:3},{value:"Roblox Server Environments",id:"roblox-server-environments",level:3}],c={toc:p};function d(e){let{components:t,...n}=e;return(0,o.kt)("wrapper",(0,a.Z)({},c,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"installation"},"Installation"),(0,o.kt)("p",null,"q is a Lua module meant to be used in Roblox Luau and vanilla Lua. Because of\nthat, you can install q in a couple of ways."),(0,o.kt)("h2",{id:"from-the-repository"},"From the Repository"),(0,o.kt)("p",null,"You can clone the repository and get the Lua files needed to use q. This is not\nauto-updating, but there are no drawbacks other than that. You need ",(0,o.kt)("inlineCode",{parentName:"p"},"git"),"\ninstalled to clone repositories. Provided that you have it installed, we can\ncontinue."),(0,o.kt)("div",{className:"admonition admonition-tip alert alert--success"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M6.5 0C3.48 0 1 2.19 1 5c0 .92.55 2.25 1 3 1.34 2.25 1.78 2.78 2 4v1h5v-1c.22-1.22.66-1.75 2-4 .45-.75 1-2.08 1-3 0-2.81-2.48-5-5.5-5zm3.64 7.48c-.25.44-.47.8-.67 1.11-.86 1.41-1.25 2.06-1.45 3.23-.02.05-.02.11-.02.17H5c0-.06 0-.13-.02-.17-.2-1.17-.59-1.83-1.45-3.23-.2-.31-.42-.67-.67-1.11C2.44 6.78 2 5.65 2 5c0-2.2 2.02-4 4.5-4 1.22 0 2.36.42 3.22 1.19C10.55 2.94 11 3.94 11 5c0 .66-.44 1.78-.86 2.48zM4 14h5c-.23 1.14-1.3 2-2.5 2s-2.27-.86-2.5-2z"}))),"tip")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"If you don't feel like cloning the repository, you can go to ",(0,o.kt)("inlineCode",{parentName:"p"},"src/q.lua"),"\nin the online Github repository and copy the code there."))),(0,o.kt)("p",null,"You can clone the repository with this command:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-bash"},"git clone https://github.com/RealNickk/q.git\n")),(0,o.kt)("p",null,"Once it finishes cloning, you can open it and inside ",(0,o.kt)("inlineCode",{parentName:"p"},"src"),", there are the source\nfiles that you can use for your own purpose."),(0,o.kt)("h3",{id:"roblox-environments"},"Roblox Environments"),(0,o.kt)("p",null,"You can create a ModuleScript in ReplicatedStorage and paste the contents of\n",(0,o.kt)("inlineCode",{parentName:"p"},"q.lua")," into it. You can then require it:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"local q = require(path.to.q)\n")),(0,o.kt)("h3",{id:"vanilla-environments"},"Vanilla Environments"),(0,o.kt)("p",null,"You can put ",(0,o.kt)("inlineCode",{parentName:"p"},"q.lua")," in your Lua includes directory to require it, or you can put\nit in a directory relative to your script and load it with a relative path."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local q = require("q") -- as include or in same directory\nlocal q = require("some/relative/path/to/q") -- as relative path\n')),(0,o.kt)("h3",{id:"exploit-environments"},"Exploit Environments"),(0,o.kt)("p",null,"Open the root directory of your exploit and find the ",(0,o.kt)("inlineCode",{parentName:"p"},"workspace")," directory.\nPaste ",(0,o.kt)("inlineCode",{parentName:"p"},"q.lua")," into the workspace directory. You can load q by doing:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local q = loadstring(readfile("q.lua"))()\n')),(0,o.kt)("div",{className:"admonition admonition-caution alert alert--warning"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"16",height:"16",viewBox:"0 0 16 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M8.893 1.5c-.183-.31-.52-.5-.887-.5s-.703.19-.886.5L.138 13.499a.98.98 0 0 0 0 1.001c.193.31.53.501.886.501h13.964c.367 0 .704-.19.877-.5a1.03 1.03 0 0 0 .01-1.002L8.893 1.5zm.133 11.497H6.987v-2.003h2.039v2.003zm0-3.004H6.987V5.987h2.039v4.006z"}))),"caution")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"Your exploit may support filesystem functions but not have a\n",(0,o.kt)("inlineCode",{parentName:"p"},"readfile")," function, instead it might have their own name for it. You will have\nto look at your exploit's documentation to see if they support filesystem\nfunctions. The functions used here are using the Unified Naming Convention,\nwhich most mainstream exploits follow."),(0,o.kt)("p",{parentName:"div"},"Not all exploits support filesystem functions. If yours does not, you will have\nto load q using a different method."))),(0,o.kt)("h2",{id:"using-loadstring"},"Using Loadstring"),(0,o.kt)("p",null,"This is referring to Roblox exploit clients or Roblox servers, but if you have\nany class that can do web requests (vanilla Lua), it'll work fine. I'm only\ngoing to explain two ways to do it, both being through Roblox. This method is\nauto-updating but will have an extremely small delay since you have to make a\nweb request."),(0,o.kt)("h3",{id:"exploit-environments-1"},"Exploit Environments"),(0,o.kt)("p",null,"Scripts in exploit environments are different from how Roblox\nscripts work. You cannot just insert a ModuleScript into the game and set the\nsource to the contents of ",(0,o.kt)("inlineCode",{parentName:"p"},"q.lua"),", as Roblox compiles the script into bytecode\nand stores it in an offset in the C++ structure of the script. Since most\nexploits do not have the ability to write bytecode to a Lua source container,\nyou will have to loadstring the contents of ",(0,o.kt)("inlineCode",{parentName:"p"},"q.lua")," every time you want to use\nq, which has the drawback of environment sharing, since there is no sandboxing,\nbut it's not a big deal unless you're doing some funky stuff."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local q = loadstring(game:HttpGet("https://github.com/RealNickk/raw/main/q/src/q.lua"))()\n')),(0,o.kt)("h3",{id:"roblox-server-environments"},"Roblox Server Environments"),(0,o.kt)("div",{className:"admonition admonition-info alert alert--info"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"14",height:"16",viewBox:"0 0 14 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"}))),"info")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"This method only works if the ModuleScript is required by the server.\n",(0,o.kt)("inlineCode",{parentName:"p"},"ServerScriptService.LoadstringEnabled")," must be set to ",(0,o.kt)("inlineCode",{parentName:"p"},"true")," to use q with this\nmethod."))),(0,o.kt)("p",null,"You can create a ModuleScript in ServerStorage and set the source to this:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local HttpService = game:GetService("HttpService")\nlocal q = loadstring(HttpService:GetAsync("https://github.com/RealNickk/raw/main/q/src/q.lua"))()\nreturn q\n')),(0,o.kt)("p",null,"You can then require it ",(0,o.kt)("strong",{parentName:"p"},"from the server")," by doing:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"local q = require(path.to.q)\n")),(0,o.kt)("div",{className:"admonition admonition-danger alert alert--danger"},(0,o.kt)("div",{parentName:"div",className:"admonition-heading"},(0,o.kt)("h5",{parentName:"div"},(0,o.kt)("span",{parentName:"h5",className:"admonition-icon"},(0,o.kt)("svg",{parentName:"span",xmlns:"http://www.w3.org/2000/svg",width:"12",height:"16",viewBox:"0 0 12 16"},(0,o.kt)("path",{parentName:"svg",fillRule:"evenodd",d:"M5.05.31c.81 2.17.41 3.38-.52 4.31C3.55 5.67 1.98 6.45.9 7.98c-1.45 2.05-1.7 6.53 3.53 7.7-2.2-1.16-2.67-4.52-.3-6.61-.61 2.03.53 3.33 1.94 2.86 1.39-.47 2.3.53 2.27 1.67-.02.78-.31 1.44-1.13 1.81 3.42-.59 4.78-3.42 4.78-5.56 0-2.84-2.53-3.22-1.25-5.61-1.52.13-2.03 1.13-1.89 2.75.09 1.08-1.02 1.8-1.86 1.33-.67-.41-.66-1.19-.06-1.78C8.18 5.31 8.68 2.45 5.05.32L5.03.3l.02.01z"}))),"danger")),(0,o.kt)("div",{parentName:"div",className:"admonition-content"},(0,o.kt)("p",{parentName:"div"},"Using this method can open up your server to serverside arbitrary code\nexecution vulnerabilities if you do not write good code. This means that people\nmay be able to execute backdoors on your game's server end, giving exploiters\nfull access to your game. I would recommend to not enable it unless you are\ntesting in a volatile environment. It's always better to be safe than sorry."))),(0,o.kt)("h1",{id:"next-step"},"Next Step?"),(0,o.kt)("p",null,"You can view the ",(0,o.kt)("a",{parentName:"p",href:"/api/q"},"API Reference")," page to learn how to use q."))}d.isMDXComponent=!0}}]);