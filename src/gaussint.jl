# This module is made for Gauss quadrature.
## 2021.8.14
## Powered by Ashen
## Nankai University


########################################################################
########################################################################
################# 高斯勒让德积分 #########################################
########################################################################


function gausslegendreint64(f)
    x,w= ([-0.9993050417357722, -0.9963401167719553, -0.9910133714767443, -0.983336253884626, -0.973326827789911, -0.9610087996520538, -0.9464113748584028, -0.9295691721319396, -0.9105221370785028, -0.8893154459951141, -0.8659993981540929, -0.8406292962525803, -0.8132653151227975, -0.7839723589433414, -0.7528199072605318, -0.7198818501716109, -0.6852363130542332, -0.6489654712546573, -0.6111553551723933, -0.571895646202634, -0.5312794640198947, -0.4894031457070531, -0.4463660172534642, -0.4022701579639918, -0.35722015833766824, -0.31132287199021125, -0.26468716220876765, -0.21742364374000725, -0.1696444204239929, -0.12146281929612088, -0.07299312178779943, -0.024350292663424446, 0.024350292663424446, 0.07299312178779943, 0.12146281929612088, 0.1696444204239929, 0.21742364374000725, 0.26468716220876765, 0.31132287199021125, 0.35722015833766824, 0.4022701579639918, 0.4463660172534642, 0.4894031457070531, 0.5312794640198947, 0.571895646202634, 0.6111553551723933, 0.6489654712546573, 0.6852363130542332, 0.7198818501716109, 0.7528199072605318, 0.7839723589433414, 0.8132653151227975, 0.8406292962525803, 0.8659993981540929, 0.8893154459951141, 0.9105221370785028, 0.9295691721319396, 0.9464113748584028, 0.9610087996520538, 0.973326827789911, 0.983336253884626, 0.9910133714767443, 0.9963401167719553, 0.9993050417357722], [0.0017832807216964326, 0.004147033260562467, 0.006504457968978363, 0.008846759826363949, 0.011168139460131126, 0.013463047896718644, 0.01572603047602472, 0.01795171577569734, 0.020134823153530212, 0.02227017380838325, 0.024352702568710864, 0.026377469715054655, 0.028339672614259476, 0.030234657072402478, 0.03205792835485155, 0.03380516183714161, 0.035472213256882386, 0.03705512854024003, 0.03855015317861562, 0.039953741132720336, 0.04126256324262353, 0.04247351512365358, 0.043583724529323443, 0.044590558163756545, 0.04549162792741815, 0.0462847965813144, 0.04696818281620999, 0.0475401657148303, 0.047999388596458276, 0.04834476223480293, 0.04857546744150339, 0.04869095700913967, 0.04869095700913967, 0.04857546744150339, 0.04834476223480293, 0.047999388596458276, 0.0475401657148303, 0.04696818281620999, 0.0462847965813144, 0.04549162792741815, 0.044590558163756545, 0.043583724529323443, 0.04247351512365358, 0.04126256324262353, 0.039953741132720336, 0.03855015317861562, 0.03705512854024003, 0.035472213256882386, 0.03380516183714161, 0.03205792835485155, 0.030234657072402478, 0.028339672614259476, 0.026377469715054655, 0.024352702568710864, 0.02227017380838325, 0.020134823153530212, 0.01795171577569734, 0.01572603047602472, 0.013463047896718644, 0.011168139460131126, 0.008846759826363949, 0.006504457968978363, 0.004147033260562467, 0.0017832807216964326])
    result=0.::Float64
    for i in eachindex(x)
        result+=f(x[i])*w[i]
    end
    result
end


function gausslegendreint(f::Function,a::Float64,b::Float64,step::Int,n::Int)
    ```
    从a到b的高斯积分，
    分为n类
    第一类是从a到b的排列是直接拉伸
    第二类是从a到b的指数伸长
    ```
    x,w= gausslegendre(step)
    result=0.::Float64
    if n==1
        #放缩系数k
        k1= (b-a)/2
        k2= (a+b)/2
        x=k2 .+(k1 .*x)
        for i in eachindex(x)
            result+=f(x[i])*w[i]
        end
        result*=(b-a)/2
    elseif n==2
        a=sqrt(a)
        b=sqrt(b)
        x=a*b*(b/a).^x
        for i in eachindex(x)
            w[i]*=x[i]*(log(b)-log(a))
            result+=f(x[i])*w[i]
        end
    end
    result
end






########################################################################
########################################################################
################# 高斯切比雪夫积分 ########################################
########################################################################
# 第二类高斯切比雪夫积分
function gausschebyshevint64(f)
    x,w= ([-0.9988322268323265, -0.9953316347176486, -0.9895063994510511, -0.9813701261394134, -0.9709418174260519, -0.9582458291091662, -0.943311813257743, -0.9261746489577763, -0.9068743608505454, -0.8854560256532098, -0.8619696668800491, -0.8364701380102267, -0.8090169943749473, -0.7796743540632223, -0.7485107481711012, -0.7155989607441211, -0.6810158587867969, -0.6448422127361707, -0.6071625078187112, -0.5680647467311557, -0.5276402441061325, -0.48598341324260613, -0.44319154559924123, -0.3993645835656953, -0.35460488704253545, -0.30901699437494734, -0.26270737819858675, -0.21578419676780602, -0.16835704134703852, -0.12053668025532288, -0.0724348001617625, -0.024163745236132295, 0.024163745236132416, 0.0724348001617624, 0.12053668025532323, 0.16835704134703863, 0.21578419676780614, 0.262707378198587, 0.30901699437494745, 0.35460488704253557, 0.39936458356569565, 0.44319154559924134, 0.4859834132426062, 0.5276402441061327, 0.5680647467311559, 0.6071625078187113, 0.6448422127361706, 0.681015858786797, 0.7155989607441211, 0.7485107481711012, 0.7796743540632224, 0.8090169943749475, 0.8364701380102267, 0.8619696668800493, 0.8854560256532099, 0.9068743608505454, 0.9261746489577766, 0.943311813257743, 0.9582458291091662, 0.970941817426052, 0.9813701261394134, 0.9895063994510511, 0.9953316347176486, 0.9988322268323266], [0.00011281616981006609, 0.0004502113450594091, 0.0010090353579028952, 0.0017840706190995188, 0.0027680808332373324, 0.003951878562074035, 0.005324411005172348, 0.006872863196919793, 0.008582777656409636, 0.010438189373044986, 0.012421774867540984, 0.014515013936583516, 0.01669836257097739, 0.018951435432794466, 0.021253196187781292, 0.023582153915944187, 0.025916563766478683, 0.028234629983582803, 0.030514709407556222, 0.032735513551151244, 0.03487630736444211, 0.03691710283239958, 0.038838845597601625, 0.040623592865634925, 0.04225468093213172, 0.04371688076728787, 0.044996540205210746, 0.04608171141051389, 0.046962262432036814, 0.047629971802143074, 0.04807860529834849, 0.04830397415057664, 0.04830397415057664, 0.04807860529834849, 0.047629971802143074, 0.046962262432036814, 0.04608171141051389, 0.044996540205210746, 0.043716880767287865, 0.04225468093213172, 0.04062359286563491, 0.038838845597601625, 0.03691710283239958, 0.03487630736444211, 0.032735513551151244, 0.030514709407556222, 0.028234629983582785, 0.025916563766478693, 0.023582153915944187, 0.021253196187781292, 0.018951435432794452, 0.01669836257097738, 0.014515013936583516, 0.012421774867540994, 0.010438189373044983, 0.008582777656409636, 0.006872863196919782, 0.005324411005172357, 0.003951878562074035, 0.0027680808332373346, 0.0017840706190995152, 0.0010090353579028943, 0.0004502113450594096, 0.00011281616981006701])
    result= 0.::Float64
    for i in eachindex(x)
        result+= f(x[i])*w[i]
    end
    result
end