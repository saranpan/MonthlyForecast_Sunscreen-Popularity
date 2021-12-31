<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 0; ALERTS: 17.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>
<a href="#gdcalert10">alert10</a>
<a href="#gdcalert11">alert11</a>
<a href="#gdcalert12">alert12</a>
<a href="#gdcalert13">alert13</a>
<a href="#gdcalert14">alert14</a>
<a href="#gdcalert15">alert15</a>
<a href="#gdcalert16">alert16</a>
<a href="#gdcalert17">alert17</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>


**Introduction**

In Thailand, sunscreen has always been an integral part of any skincare routine. With the emergence of self-care culture, there has never been a more beneficial time to enter the sun protection market and capitalize on skincare popularity. The goal of this project is to forecast the search count for ‘ครีมกันแดด’ on Google, which we interpret as as a proxy for Thai consumer interest in sunscreen throughout the time period. The results can be used by companies selling sun protection to gauge which time of the year is best to launch targeted advertisements and marketing campaigns for sunscreen, to increase product sales and the generated revenue.

**Data**

**	**Our dataset contains information regarding the frequency in which ‘ครีมกันแดด’ is looked up on Google each month from January 2009 to December 2021. The data is extracted from Google Trends via the following link:

[https://trends.google.co.th/trends/explore?date=2008-12-12%202021-12-12&geo=TH&q=%E0%B8%84%E0%B8%A3%E0%B8%B5%E0%B8%A1%E0%B8%81%E0%B8%B1%E0%B8%99%E0%B9%81%E0%B8%94%E0%B8%94](https://trends.google.co.th/trends/explore?date=2008-12-12%202021-12-12&geo=TH&q=%E0%B8%84%E0%B8%A3%E0%B8%B5%E0%B8%A1%E0%B8%81%E0%B8%B1%E0%B8%99%E0%B9%81%E0%B8%94%E0%B8%94)

( Note: The popularity on the December 2021 may change when time passes, since we retrieved it at 12 dec 2021, so, the data is incomplete to gather the actual popularity)

The extracted dataset can be accessed via the following link:

[https://github.com/wallik2/Forecast_Sunscreen-popularity/blob/main/SunScreen.csv](https://github.com/wallik2/Forecast_Sunscreen-popularity/blob/main/SunScreen.csv)

It contains 156 observations and two columns, as follows:



1. <span style="text-decoration:underline;">Month: </span>the month the search results occurred in
2. <span style="text-decoration:underline;">Sunscreen (Thailand): </span>normalized count of ‘ครีมกันแดด’ Google search that took place in Thailand

Google Trends data removes all personally identifying information. Moreover, it is normalized based on the time and location of a query. “Each data point is divided by the total searches of the geography and time range it represents to compare relative popularity” to prevent locations with the largest search volume from always ranking the highest (“FAQ about Google Trends data”, n.d.). The results are then scaled on a range of 0 to 100 relative to the proportion of a topic to all searches on all topics, with 0 representing no interest and 100 signifying maximum search interest for the time and location selected. Normalization allows for deeper insights to be gained from the data by comparing different dates and different locations (Rogers, 2016).

	For this project, we defined a quarter as a period of 3 months from January 2009 to December 2021. There are 52 quarters and 156 months. 

**Project Set Up**

The following R code is how we prepare and set up the environment for this project.


```
#Setup
library(forecast);
library(tseries);
library(glue);
df <- read.csv('Sunscreen.csv',header=TRUE)

df.ts = ts(Sunscreen..Thailand. , 
           start=c(2009,1),freq=12)
```


Remark: We set frequency to 12 as one year has 12 months

**Exploratory Data Analysis (EDA)**

First, we will examine the descriptive statistics of the data for the entire period of time between January 2009 to December 2021.


```
summary(df.ts)
```



```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  13.00   29.00   42.00   42.97   53.25  100.00 
```


The minimum search count for ‘ครีมกันแดด’ is not zero, suggesting that there has always been consumer interest in the product. This implies that sunscreen is a necessity, not a luxury item.

Before forecasting the popularity of sunscreen searches, we need to understand how our data looks like first.


```
plot(df.ts,main ='Monthly searches "Sunscreen" (2009-2021) ',
     xlab="Year",ylab="Popularity",) 
```




<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")


**Figure 1 : The monthly searches sunscreen (2009-2021)**

Figure 1 shows the search count across years. There is an increasing trend from 2009-2019, implying that sunscreen rose in popularity throughout the years. This may be due to the increase in skin care popularity, or the growth in online sunscreen sales that requires consumers to look up the product on Google, or a combination of both. A decreasing trend can be observed from 2019-2021. This may be a result of COVID-19 lockdown, where people had no need to leave the confines of their homes resulting in a lower need for sun protection. 

Next, we look at the mean of each year. Figure 2 shows that the individual annual means are not equal to the mean of the series, which has the value 42.97. There is an increasing trend from 2009-2019, and a decreasing trend from 2019-2021. This follows the same distribution as annual search frequency.


```
plot(aggregate(df.ts,FUN='mean'),main ='Annual mean of searches "Sunscreen" (2009-2021) ',
     xlab="Year",ylab="Popularity",)
```




<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


**Figure 2 : Annual mean of searches "Sunscreen" (2009-2021)**


```
boxplot(df.ts ~ cycle(df.ts),main ='Popularity of each month',
        xlab="Month",ylab="Popularity")
```




<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


**Figure 3 : Box plot for each month (2009-2021)**

After investigating the trend of this data, we will now investigate the seasonal pattern using box plot as shown in figure 3. There is an increasing trend from January to March, and a spike in popularity of sunscreen in April. This coincides with the peak of Thailand’s summer. The slow decrease from May to December follows the drop in Thailand’s temperature. Since the mean is not constant for every month, this suggests that the data has a seasonal component. 


```
layout(1:3)
df0913=window(df.ts, start=c(2009,1), end=c(2013,12))
df1418=window(df.ts, start=c(2014,1), end=c(2018,12))
df1822=window(df.ts, start=c(2018,1), end=c(2022,12))
plot(df0913,main="Time series of each time periods")
plot(df1418)
plot(df1822)
```




<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


**Figure 4 : Explicitly monthly searches sunscreen (2009-2021)**

Figure 4 shows that the peak in April, and the slow downward slope for the following months, is a recurring trend for all the time periods. The data is seasonal.


```
layout(1:3)
boxplot(df0913~cycle(df0913),main="2009-2013",ylim = c(0, 100))
boxplot(df1418~cycle(df1418),main="2014-2018",ylim = c(0, 100))
boxplot(df1822~cycle(df1822),main="2018-2022",ylim = c(0, 100))
```




<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


**Figure 5 : Explicitly Boxplot (2009-2021)**

To consolidate our proof that the data is seasonal, we use figure 5 to demonstrate that the data is increasing- the popularity of sunscreen increases throughout the years. However, the distribution of search count, left skewed normal distribution, remains constant for every time period.

**Model Selection**

We are interested in using an ARIMA model to forecast the search count of ‘ครีมกันแดด’ in Thailand. There are** **5** **potential models, as follows:


<table>
  <tr>
   <td>1
   </td>
   <td>MA(q)
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>AR(p)
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>ARMA(p,q)
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>ARIMA(p,d,q)
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>SARIMA(p,d,q)(P,D,Q)m
   </td>
   <td>
   </td>
  </tr>
</table>


 

To determine which model fits our data the best, we will use two methods: naked eye observation and statistical methods.



1. **<span style="text-decoration:underline;">Naked Eye Observation</span>**

Recall from figure 1 that our time series is not stationary since there is an increasing trends and seasonal components that violate the following properties:

**property 1**. The mean does not change over time

**property 3**. No seasonality

Therefore, with our naked eye, we eliminate the first 3 models, since those models are not suitable for non-stationary series, so the possible models we could use are ARIMA and SARIMA. With our data being seasonal, it could be more fitting to use a SARIMA model. However, our naked eyes are not a statistical method, and we cannot provide conclusive evidence using this measure to determine that we should use a SARIMA model. In the next section, we will come to the decision via statistical methods.



2. **<span style="text-decoration:underline;">Statistical method</span>**

First, we will investigate the MA(q) and AR(p) models. The most common way to do so is observing the autocorrelation function and partial autocorrelation function through a correlogram. A good rule of thumb states that the maximum number of lags is

              **   max lag = (the number of observation / 4)**

**                               =  156 / 4**

**                               =  39**

Hence, we will investigate the ACF at lag 1 to 39.


```
layout(1:2)
Acf(df.ts,main='ACF',lag.max=156/4)
Pacf(df.ts,main='PACF',lag.max=156/4)
```




<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


**Figure 6 : ACF & PACF of the time series data**

According to figure 6, ACF exhibits a slow decay pattern for the seasonal part and does not exhibit a cut off pattern after q significant lags. This suggests a nonstationarity that can be remedied by taking the first difference. Hence, we conclude that the **moving average (MA) model is not appropriate for this time series. **

Moving on to the PACF plot, it seems to exhibit a cut-off after lag 1 pattern for the non-seasonal part, but if we inspect the PACF carefully, we can see that every lag _12n_ has a non-significant zero autocorrelation, which is an indicator of seasonality. Although PACF has a cut-off pattern, it still is not enough evidence to suggest that we should use an AR** **model, since the PACF plot shows neither exponential smoothing nor damped sinusoidal pattern, we can conclude that **autoregressive model (AR) is not appropriate for this time series.**

Since both ACF and PACF patterns are neither exponential smoothing nor damped sinusoidal, we can conclude that the **autoregressive moving average model (ARMA) is not appropriate for this time series.**

In summary, the model MA, AR, and ARMA are not appropriate for our time series based on the diagnostics performed on ACF and PACF plots. 


<table>
  <tr>
   <td>1
   </td>
   <td>MA(q)
   </td>
   <td><a href="https://emojipedia.org/cross-mark/">❌</a>
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>AR(p)
   </td>
   <td><a href="https://emojipedia.org/cross-mark/">❌</a>
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>ARMA(p,q)
   </td>
   <td><a href="https://emojipedia.org/cross-mark/">❌</a>
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>ARIMA(p,d,q)
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>SARIMA(p,d,q)(P,D,Q)m
   </td>
   <td>
   </td>
  </tr>
</table>


To choose between the remaining two models, we will first prove that the series is non-stationary again, this time using a statistical measure: the Dickey-Fuller test. First, we set the hypotheses as follows:

**Null hypothesis : The time series is stationary**

**Alternative hypothesis : The time series is non- stationary**


```
adf.test(df.ts) 
```


**	Augmented Dickey-Fuller Test**

**data:  df.ts**

**Dickey-Fuller = -2.6099, Lag order = 5, p-value = 0.3221**

**alternative hypothesis: stationary**

The p-value is not small enough to reject the null hypothesis, this means that this time series is not stationary. This goes in line with our naked eye observation.

We will now move on to the ARIMA model that can be fit on non-stationary time series (with assumed constant variance). Since our time series has a linear fashion trend, it is possible to fit with an ARIMA or SARIMA model.

To prove that the series does follow a linear trend, we plot the first and second order differencing, as shown in figure 7.


```
layout(1:2)
plot(diff(df.ts,differences = 1),main='1st order differencing')
abline(h=0,lty = 2,col='red')
plot(diff(df.ts,differences = 2),main='2nd order differencing')
abline(h=0,lty = 2,col='red')
```




<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")


**Figure 7 :Order Differencing**

According to figure 7, we decided to use first order differencing, since the differenced series resembles a white noise series more than the second order differencing. Both orders of differenced series experience more volatile fluctuation around 2019, however the magnitude of fluctuation of the second order differenced series is greater. This suggests that variance is not constant over time, therefore it does not meet the condition. We will proceed with the first order differenced series. From the time series plot, it looks like some seasonality has been removed by first differencing coupled with seasonal differencing. However, we cannot make that conclusion without first seeing the ACF and PACF plots.


```
df.ts.diff = diff(df.ts,differences = 1)
```



```
layout(1:2)
Acf(df.ts.diff,main='[1st diff] ACF',lag.max=156/4)
Pacf(df.ts.diff,main='[1st diff] PACF',lag.max=156/4)
```




<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


**Figure 8 :ACF and PACF of first order differencing**

According to figure 8, the ACF of the first differenced series shows no pattern for the non-seasonal part but still exhibits a slow decay pattern for the seasonal part. PACF shows no pattern for the non- seasonal part, but still cuts off after lag 24 (lag 2). This suggests that some seasonality still remains. Therefore, we cannot use ARIMA(p,d,q).

This leads us to the last model, the SARIMA model.


<table>
  <tr>
   <td>1
   </td>
   <td>MA(q)
   </td>
   <td><a href="https://emojipedia.org/cross-mark/">❌</a>
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>AR(p)
   </td>
   <td><a href="https://emojipedia.org/cross-mark/">❌</a>
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>ARMA(p,q)
   </td>
   <td><a href="https://emojipedia.org/cross-mark/">❌</a>
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>ARIMA(p,d,q)
   </td>
   <td><a href="https://emojipedia.org/cross-mark/">❌</a>
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>SARIMA(p,d,q)(P,D,Q)m
   </td>
   <td>
   </td>
  </tr>
</table>


In order to find the best parameter order(p,d,q) and seasonal order(P,D,Q) that yields the best model performance based on AIC criterion, we decided to use auto.arima from the package _forecast_. (given_ m_=12)


```
auto.arima(df.ts,stationary = FALSE,seasonal=TRUE,ic = 'aic',stepwise = FALSE, trace=TRUE,
           approximation = FALSE)
```



```
Best model: ARIMA(0,1,2)(2,1,0)[12] 

Series: df.ts 
ARIMA(0,1,2)(2,1,0)[12] 

Coefficients:
          ma1      ma2     sar1     sar2
      -0.4494  -0.1952  -0.6587  -0.3370
s.e.   0.0890   0.0975   0.0835   0.0941

sigma^2 estimated as 68.06:  log likelihood=-505.99
AIC=1021.97   AICc=1022.41   BIC=1036.79
```


This tells us that the parameters (p=0,d=1,q=2), (P=2,D=1,Q=0)(m=12) are the best amongst all the parameters; it yields the model the lowest AIC value of 1021.97. However, most of the AIC values were returned as** inf, **which is not a good sign, and does not guarantee that this is really the best model. So, we decided to build the models whose returned AIC values were **_inf_** manually.

auto.arima return **inf **for** ARIMA(0,1,0)(0,1,1)[12].** The following R command gives us the exact AIC of that model


```
Arima(df.ts, order = c(0,1,2),seas = list(order = c(1,1,1), 12))$aic
> 1031.302
```


So, we obtain AIC 1031.302 instead of **inf**

**_ \
_**After we repeated the step for every model whose AIC was returned as inf, we got the following results. 


<table>
  <tr>
   <td>
   </td>
   <td><strong>AIC</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,0)(0,1,1)[12]</strong>
   </td>
   <td><strong>1031.302</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,0)(0,1,2)[12]</strong>
   </td>
   <td><strong>1032.521</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,0)(1,1,1)[12]</strong>
   </td>
   <td><strong>1032.635</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,0)(1,1,2)[12] </strong>
   </td>
   <td><strong>1033.265</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,0)(2,1,1)[12] </strong>
   </td>
   <td><strong>1033.699</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,0)(2,1,2)[12]</strong>
   </td>
   <td><strong>1035.109</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,1)(0,1,1)[12]</strong>
   </td>
   <td><strong>1010.825</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,1)(0,1,2)[12]</strong>
   </td>
   <td><strong>1012.456</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,1)(1,1,1)[12]</strong>
   </td>
   <td><strong>1012.446</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,1)(1,1,2)[12] </strong>
   </td>
   <td><strong>1012.375</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,1)(2,1,1)[12] </strong>
   </td>
   <td><strong>1014.405</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,1)(2,1,2)[12]</strong>
   </td>
   <td><strong>1014.336</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(0,1,2)(0,1,1)[12] </strong>
   </td>
   <td><strong>1006.738</strong>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td><strong> ARIMA(0,1,2)(0,1,2)[12] </strong>
   </td>
   <td><strong>1008.574</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,2)(1,1,1)[12]    </strong>
   </td>
   <td><strong>1008.574</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,2)(1,1,2)[12]  </strong>
   </td>
   <td><strong>1008.988</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,2)(2,1,1)[12]   </strong>
   </td>
   <td><strong>1010.574</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,3)(0,1,1)[12]  </strong>
   </td>
   <td><strong>1007.707</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,3)(0,1,2)[12]     </strong>
   </td>
   <td><strong>1009.616</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,3)(1,1,1)[12]   </strong>
   </td>
   <td><strong>1009.615</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(0,1,4)(0,1,1)[12]   </strong>
   </td>
   <td><strong>1009.468</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(1,1,0)(0,1,1)[12]  </strong>
   </td>
   <td><strong>1022.789</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,0)(0,1,2)[12]  </strong>
   </td>
   <td><strong>1023.908</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,0)(1,1,1)[12] </strong>
   </td>
   <td><strong>1023.971</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,0)(1,1,2)[12] </strong>
   </td>
   <td><strong>1023.968</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,0)(2,1,1)[12]   </strong>
   </td>
   <td><strong>1025.766</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,0)(2,1,2)[12]       </strong>
   </td>
   <td><strong>1025.966</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,1)(0,1,1)[12]       </strong>
   </td>
   <td><strong>1008.781</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,1)(0,1,2)[12]   </strong>
   </td>
   <td><strong> 1010.481</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,1)(1,1,1)[12]    </strong>
   </td>
   <td><strong>1010.477</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,1)(1,1,2)[12]    </strong>
   </td>
   <td><strong>1010.503</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,1)(2,1,1)[12]   </strong>
   </td>
   <td><strong>1012.466</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,2)(0,1,1)[12]     </strong>
   </td>
   <td><strong>1007.693</strong>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td><strong> ARIMA(1,1,2)(0,1,2)[12]     </strong>
   </td>
   <td><strong>1009.596</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,2)(1,1,1)[12]             </strong>
   </td>
   <td><strong>1009.596</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(1,1,3)(0,1,1)[12]   </strong>
   </td>
   <td><strong>1009.629</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,0)(0,1,1)[12]  </strong>
   </td>
   <td><strong>1008.343</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,0)(0,1,2)[12]    </strong>
   </td>
   <td><strong>1010.236</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,0)(1,1,1)[12]     </strong>
   </td>
   <td><strong>1010.239</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,0)(1,1,2)[12]  </strong>
   </td>
   <td><strong>1011.199</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,0)(2,1,1)[12]</strong>
   </td>
   <td><strong>1012.206</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,1)(0,1,1)[12]    </strong>
   </td>
   <td><strong>1008.343</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,1)(0,1,2)[12]  </strong>
   </td>
   <td><strong>1010.236</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,1)(1,1,1)[12]  </strong>
   </td>
   <td><strong>1010.743</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,2)(0,1,0)[12] </strong>
   </td>
   <td><strong>1066.829</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,2)(0,1,1)[12]    </strong>
   </td>
   <td><strong>1009.555</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(2,1,3)(0,1,0)[12]   </strong>
   </td>
   <td><strong>1063.955</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(3,1,0)(0,1,1)[12]    </strong>
   </td>
   <td><strong>1010.029</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(3,1,0)(0,1,2)[12] </strong>
   </td>
   <td><strong>1011.91</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(3,1,0)(1,1,1)[12]  </strong>
   </td>
   <td><strong>1011.913</strong>
   </td>
  </tr>
  <tr>
   <td><strong>ARIMA(3,1,1)(0,1,1)[12]                    </strong>
   </td>
   <td><strong>1009.226</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(3,1,2)(0,1,0)[12]</strong>
   </td>
   <td><strong>1064.731</strong>
   </td>
  </tr>
  <tr>
   <td><strong> ARIMA(4,1,0)(0,1,1)[12]</strong>
   </td>
   <td><strong>1010.326</strong>
   </td>
  </tr>
</table>


From the table of manually obtained AIC values above, **ARIMA(0,1,2)(0,1,1)[12] **has the lowest AIC value and is the best model among all of the possible models. Therefore, we picked this model over what auto.arima() chose for us.

Next, we will further explore this model.

**SARIMA with (p=0,d=1,q=2)(P=0,D=1,Q=1)[m=12]**


```
SARIMA.012.011.12 = Arima(df.ts, order = c(0,1,2),
                       seas = list(order = c(0,1,1), 12))

summary(SARIMA.012.011.12)
```



```
Series: df.ts 
ARIMA(0,1,2)(0,1,1)[12] 

Coefficients:
          ma1      ma2     sma1
      -0.3748  -0.2363  -1.0000
s.e.   0.0873   0.0915   0.1272

sigma^2 estimated as 51.93:  log likelihood=-499.37
AIC=1006.74   AICc=1007.03   BIC=1018.59

Training set error measures:
                     ME    RMSE      MAE       MPE     MAPE      MASE
Training set -0.5476159 6.82672 5.072097 -3.231341 12.34181 0.4995772
                    ACF1
Training set -0.03094107

Result
```


First of all, we need to check the significance of each parameter in this model. If there is zero within the 95% confidence interval then we can conclude that that parameter is not significant.

There are 3 parameters :  **θ<sub>1 </sub>**(as ma1)**, θ<sub>2 </sub>**(as ma2)** , **and **Θ<sub>1 </sub>**(as sma1). The 95% CI of each parameter are as following

**θ<sub>1</sub>**= 0.3748 ±  2(0.0873)  =   (0.2002, 0.5494)  

**θ<sub>2</sub>**= 0.2363 ± 2(0.0915)   =   (0.0533,0.4193

**Θ<sub>1 </sub>**= 1.00 ± 2(0.1272)     =  (0.7456,1.2544)

According to their 95% confidence interval, none of the three parameters have zero in their interval. Hence, we can conclude that every parameter is significant at the level of 95%, we do not have to drop any parameter. In the next section we will statistically diagnose this model to determine if it is suitable to forecast the search count of sunscreen.

**Diagnosis**

We will check whether the residuals of this model behave like white noise or not. The three properties of white noises are as follows:



1. The mean is zero over time
2. The variance is constant over time
3. Uncorrelated in time

    ```
plot(model$residuals,main='Residual plot by SARIMA(0,1,2)(2,1,0)(12)')
abline(h=0,lty = 2,col='red')
```





<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


**Figure 9 :Residual plot of SARIMA(0,1,2)(0,1,1)[12]**

According to figure 9, we could see that the residual mean of this model is roughly zero over time. Furthermore, the variance is quite stable. The residuals satisfy the first two properties of white noise, and we can conclude that the residuals behave like white noise. This suggests that this model is a good fit for the time series.


```
hist(model$residuals)
```




<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


** Figure 10 :Histogram of Residual plot of SARIMA(0,1,2)(0,1,1)[12]**

Figure 10 supports that the residual behaves like gaussian white noise, since it follows a normal distribution with zero mean. This suggests that this model is a good fit for the time series. Next, we are going to check whether the residuals are uncorrelated in time or not. We are going to use the ACF plot to see if the autocorrelation is independent. (See figure 11)


```
Acf(model$residuals,lag.max = 156/4, main='ACF plot of residual'))
```




<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


** Figure 11 :ACF plot of Residual of SARIMA(0,1,2)(0,1,1)[12]**

According to figure 11, lags 18 and 23 are significant but they can be interpreted as 5% false alarm. Now, we will perform the Ljung box test.



1. **Hypothesis test** : 

Ho: p<sub>0</sub> = p<sub>1</sub> = p<sub>2 </sub>= … = p<sub>39</sub> = 0

H<sub>A</sub> : at least the autocorrelation of one lagged version is not zero



2. **Ljung-Box test**

According to figure 12, there is no lagged version that is significant below the 95% CI blue horizontal dashed line 


```
# Create a function to extract the plot of tsdiag()
# ref : tpetzoldt comment in 
# https://stackoverflow.com/questions/70079957/save-only-one-plot-from-tsdiag
tsdiag.Arima <- tsdiag.arima0 <- function(object, gof.lag = 10, which = 1L:3L, ...) {
    ## plot standardized residuals, acf of residuals, Ljung-Box p-values
    oldpar <- par(mfrow = c(length(which), 1))
    on.exit(par(oldpar))
    rs <- object$residuals
    if (1L %in% which) {
      stdres <- rs/sqrt(object$sigma2)
      plot(stdres, type = "h", main = "Standardized Residuals", ylab = "")
      abline(h = 0)
    }
    if (2L %in% which) {
      acf(object$residuals, plot = TRUE, main = "ACF of Residuals",
          na.action = na.pass)
    }
    if (3L %in% which) {
      nlag <- gof.lag
      pval <- numeric(nlag)
      for(i in 1L:nlag) pval[i] <- Box.test(rs, i, type="Ljung-Box")$p.value
      plot(1L:nlag, pval, xlab = "lag", ylab = "p value", ylim = c(0,1),
           main = "p values for Ljung-Box statistic")
      abline(h = 0.05, lty = 2, col = "blue")
    }
  } 

tsdiag(model, gof.lag=156/4 ,which=3)
```




<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")


**Figure 12 :Ljung Box test**

Hence, we can conclude that the residuals have no autocorrelation in time. So, we verify that the residual behaves like (gaussian) white noise. 

The summary of our proof that the residuals behave like gaussian white noise is shown using tsdiag(). (See figure 13). This suggests that ** **SARIMA(0,1,2)(0,1,1)[12] is a good fit for our data.


```
tsdiag(model)
```




<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


**Figure 13 :Diagnosis of SARIMA(0,1,2)(0,1,1)[12]**

**Results**

These are the results of our findings. Figure 14 shows the predicted values using ** **SARIMA(0,1,2)(0,1,1)[12] compared to the actual values for the period of 2009-2021.


```
plot(df.ts,main='Fitted SARIMA(0,1,2)(0,1,1)(12)')
lines(fitted(model),col ='green',lwd=2)
legend(2010, 90, legend=c("Actual", "Prediction"),
       col=c("black", "green"), lty=1:1, lwd=1:2,cex=0.8)
```




<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


**Figure 14 :Fitted SARIMA(0,1,2)(0,1,1)(12)  model**

There is little discrepancy between the actual values and the predicted values. This indicates that the model is a good fit for the data. Moreover, overfitting is also not present as we have already checked the significance of the three parameters earlier.

Hence, we could expect that the model is reliable in forecasting the next 6 months or 12 months. However, we do not expect it to forecast accurately for the next 5 years (60 months), since the standard error would be extremely high (See figure 17). 


```
forc = forecast(model , h = 6)
plot(forc, main='Forecast in next 6 months by SARIMA(0,1,2)(0,1,1)(12)')

forc = forecast(model , h = 12)
plot(forc, main='Forecast in next 12 months by SARIMA(0,1,2)(0,1,1)(12)')

forc = forecast(model , h = 60)
plot(forc, main='Forecast in next 60 months by SARIMA(0,1,2)(0,1,1)(12)')
```




<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


**Figure 15 : Forecast of the next 6 months**



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")


**Figure 16 : Forecast of the next 12 months**



<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image17.png "image_tooltip")


**Figure 17 : Forecast of the next 60 months**

Figure 15, figure 16, and figure 17 show the model forecast for the next 6, 12, 60 months respectively. Note that the dark blue area around the prediction represents 80% confidence interval, while gray represents 95% confidence interval.

The least accurate forecasting results can be observed in figure 17. From 2021-2026, the area of the standard error increases steadily. This means that, the further the forecasted year is from the starting point 2021, the less accurate the forecasted values become.

On the other hand, figure 15, which shows the forecast of the next six months shows a much lower standard error; with the standard error remaining constant throughout the forecasted period. Figure 16, which shows the forecast of the next 12 months shows a slowly increasing standard error starting from six months onwards. This suggests that the forecast is only accurate for the first six months.

We conclude that we will use this model to forecast up to six months. The information below is the actual values of the six month forecast using SARIMA(0,1,2)(0,1,1)[12].


```
forecast(model , h = 6)
```



```
         Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
Jan 2022       32.27683 22.67180 41.88186 17.58720 46.96646
Feb 2022       35.88273 24.56185 47.20361 18.56894 53.19652
Mar 2022       45.26735 33.34861 57.18608 27.03921 63.49548
Apr 2022       56.19042 43.70242 68.67843 37.09167 75.28918
May 2022       45.11350 32.08107 58.14593 25.18212 65.04489
Jun 2022       39.65197 26.09696 53.20698 18.92137 60.38256
```


The above result can be interpreted in a form of table below (See figure 18).


<table>
  <tr>
   <td>
   </td>
   <td><strong>80% confidence interval</strong>
   </td>
   <td><strong>95% confidence interval</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Jan 2022</strong> 
   </td>
   <td>[22.67180,41.88186]
   </td>
   <td>[17.587,46.96646]
   </td>
  </tr>
  <tr>
   <td><strong>Feb 2022</strong>
   </td>
   <td>[24.56185,47.20361]
   </td>
   <td>[18.56894,53.19652]
   </td>
  </tr>
  <tr>
   <td><strong>Mar 2022</strong>
   </td>
   <td>[33.34861,57.18608]
   </td>
   <td>[27.03921 63.49548]
   </td>
  </tr>
  <tr>
   <td><strong>Apr 2022</strong>
   </td>
   <td>[43.70242,68.67843] 
   </td>
   <td>[37.09167 75.28918]
   </td>
  </tr>
  <tr>
   <td><strong>May 2022</strong>
   </td>
   <td>[32.08107,58.14593]
   </td>
   <td>[25.18212 65.04489]
   </td>
  </tr>
  <tr>
   <td><strong>Jun 2022</strong>
   </td>
   <td>[26.09696,53.20698]
   </td>
   <td>[18.92137 60.38256]
   </td>
  </tr>
</table>


**Figure 18 : The 80% and 95% confidence interval of the forecast value in the next 6 months**

We will demonstrate how to interpret the above table. 

Suppose we were interested in the range of popularity with 80% and 95% confidence level in January 2022.

According to figure 18, there is a 20% chance that the actual popularity is not in the range [22.67180,41.88186]. Similarly there is a 5% chance that the actual popularity is not in the range [17.587,46.96646].

**Mathematics behind SARIMA(0,1,2)(0,1,1)(12).**

The following equation is our fitted SARIMA(0,1,2)(0,1,1)(12) model 

The forecasted search count can be represented as

**ŷ<sub>t </sub>= y<sub>t-1</sub> + y<sub>t-12</sub> - y<sub>t-13</sub> -  ε<sub>t-12</sub> - 0.3748 ε<sub>t-1</sub> +  0.3748 ε<sub>t-13</sub> - 0.2363 ε<sub>t-2</sub>  + 0.2363 ε<sub>t-14</sub>  **

Where ŷ<sub>t</sub> is the forecast value

           y<sub>t-k </sub>is the actual search term count at the past lagged k value

           ε<sub>t-k </sub>is the residuals of the model at the past lagged k value

Next, we will explore how can we obtain those y<sub>t-k </sub> , ε<sub>t-k </sub>

**y<sub>t-k </sub>**


```
df.ts
```



```
     Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
2009  15  26  27  32  14  24  23  16  25  17  22  20
2010  19  30  49  45  42  35  32  24  24  22  21  20
2011  17  27  24  31  25  23  25  25  13  23  29  19
2012  27  28  35  41  44  28  29  28  26  31  31  24
2013  28  21  31  52  46  34  35  31  30  29  37  24
2014  33  37  47  61  46  40  43  43  34  42  41  36
2015  34  46  65  88  63  68  55  59  63  51  50  48
2016  42  42  55  78  60  45  49  42  40  34  42  41
2017  50  61  75  89  79  62  68  69  48  49  61  59
2018  57  67  78  87  71  62  61  57  58  60  56  43
2019  48  53  66 100  66  56  56  47  45  53  52  43
2020  54  51  47  45  53  67  47  44  46  38  49  45
2021  40  48  60  52  48  42  33  30  31  28  24  31
```


Suppose you were interested at forecasting the Jan 2022, then 

Y<sub>t-1</sub> is at  Dec 2021 which is 31 

Y<sub>t-12</sub> is at Jan 2021 which is 40

ε<sub>t-k</sub>


```
model$residuals
```



```
               Jan           Feb           Mar           Apr           May           Jun           Jul
2009  8.660251e-03  1.239354e-02  8.958624e-03  1.108694e-02 -7.437281e-03  3.010472e-03  1.647060e-03
2010 -5.924855e-02 -1.484103e-04  1.198506e+01 -2.440664e+00  1.227092e+01 -8.087379e+00 -1.528363e+00
2011 -5.318291e+00 -2.904047e+00 -1.257903e+01  7.357520e-02  7.684684e-01 -2.551106e+00  2.492903e+00
2012  7.614414e+00 -6.246997e+00  5.926399e-01  1.637758e+00  1.112600e+01 -9.598005e+00  4.775137e-01
2013  1.144849e+00 -1.352925e+01 -1.149741e+00  1.202660e+01  4.215568e+00 -2.963604e+00  1.003448e+00
2014  4.912596e+00 -6.378521e-01  3.819115e+00  7.657400e+00 -4.450735e+00 -4.060312e-01  1.535319e+00
2015 -5.272851e+00  4.897171e+00  1.137506e+01  1.912479e+01 -6.361074e+00  1.185304e+01 -9.559704e+00
2016 -9.626251e+00 -9.244304e+00 -1.961202e+00  8.975130e+00 -4.585585e+00 -9.886456e+00  2.905906e-01
2017  8.516791e+00  9.313735e+00  9.712933e+00  7.832176e+00  6.167126e+00 -6.799487e+00  5.272728e+00
2018 -2.094108e+00  3.949590e+00  1.930984e+00 -1.296187e+00 -4.877644e+00 -4.346885e+00 -3.729689e+00
2019 -2.252414e+00 -4.328867e+00  6.158796e-01  2.037110e+01 -1.377104e+01 -3.303405e+00 -4.395652e+00
2020  6.365830e+00 -7.162205e+00 -1.492547e+01 -2.242032e+01  8.616897e+00  1.821190e+01 -1.020076e+01
2021 -5.418460e+00  1.029729e+00  1.829975e+00 -1.876461e+01  7.681723e-01 -4.705146e+00 -8.547262e+00
               Aug           Sep           Oct           Nov           Dec
2009 -5.135036e-03  3.950545e-03 -4.055070e-03  1.092038e-03 -1.370979e-02
2010 -3.171048e+00 -7.902305e+00  5.383424e-01 -5.905755e+00 -1.647770e+00
2011  6.451937e+00 -1.046608e+01  9.849697e+00  4.484219e+00 -3.009609e+00
2012  1.376493e+00 -2.375591e-01  4.566099e+00 -1.231685e+00 -1.617267e+00
2013 -3.240135e-01  3.392106e-01 -1.961858e+00  4.264199e+00 -5.876639e+00
2014  4.130601e+00 -5.209681e+00  5.596033e+00 -3.332713e+00  1.650686e+00
2015  6.006944e+00  6.010469e+00 -9.289689e+00 -5.610636e+00 -2.594293e-01
2016 -6.636278e+00 -2.819284e+00 -8.236948e+00  1.592003e+00  3.098437e+00
2017  4.022960e+00 -1.551343e+01 -3.213877e+00  3.615551e+00  3.553846e+00
2018 -3.900360e+00  2.189654e+00  2.323581e+00 -6.201293e+00 -9.572659e+00
2019 -8.529863e+00 -2.995850e+00  4.775669e+00 -2.922455e+00 -3.208818e+00
2020  6.536651e-01  2.796198e+00 -6.892198e+00  5.910974e+00  2.440307e+00
2021 -4.154788e+00  2.635912e-02 -3.613856e+00 -8.554037e+00  8.219087e+00
```


Again, Suppose you were interested at forecasting the Jan 2022, then 

ε<sub>t-1</sub> is at  Dec 2021 which is -5.41846

ε<sub>t-12</sub> is at Jan 2021 which is 40

** **Demonstration of Forecasting

**SARIMA(0,1,2)(0,1,1)(12).**

**Hence, the forecast value at the Jan 2022 is**

**ŷ<sub>t </sub>-y<sub>t-1</sub> + y<sub>t-12</sub> - y<sub>t-13</sub> = - 0.2363 ε<sub>t-2</sub> -0.3748 ε<sub>t-1</sub> +  0.3748 ε<sub>t-13</sub> -  ε<sub>t-12</sub> + 0.2363 ε<sub>t-14</sub> **

**ŷ<sub>t </sub>= y<sub>t-1</sub> + y<sub>t-12</sub> - y<sub>t-13</sub> -  ε<sub>t-12</sub> -0.3748 ε<sub>t-1</sub> +  0.3748 ε<sub>t-13</sub> - 0.2363 ε<sub>t-2</sub>  + 0.2363 ε<sub>t-14</sub>  **

**   = 31 + 40 - 45 - -5.41846 - 0.3748 (8.219087) +  0.3748(2.440307)**

** - 0.2363(-8.554037)  + 0.2363(5.910974)**

**   **

**   ≈ 32.27683**

The forecast value at the Jan 2022 is 32.27683,

Similarly if you want to get the lower bound at 95% confidence interval.


```
θ1= 0.3748 ±  2(0.0873)  =   (0.2002, 0.5494)  
θ2= 0.2363 ± 2(0.0915)   =   (0.0533,0.4193
Θ1 = 1.00 ± 2(0.1272)     =  (0.7456,1.2544)

Just use (θ1  θ2  Θ1  )  = (0.2002, 0.0533 ,0.7456) instead of (0.3748,0.2363,1).
```


**Conclusion**

	We have demonstrated how the search count of the term ‘ครีมกันแดด’ on Google could be analyzed, and have forecasted the search count for the next six months, January 2022 to June 2022, using the model with the lowest AIC value, SARIMA(0,1,2)(0,1,1)(12). We hope our findings can aid in gauging the popularity of sunscreen, and help skincare companies launch more effective and timely marketing campaigns to increase their sun protection sales.

**References**

Google Trend of ‘ครีมกันแดด’. Retrieved December 12, 2021, from [https://trends.google.co.th/trends/explore?date=2008-12-12%202021-12-12&geo=TH&q=%E0%B8%84%E0%B8%A3%E0%B8%B5%E0%B8%A1%E0%B8%81%E0%B8%B1%E0%B8%99%E0%B9%81%E0%B8%94%E0%B8%94](https://trends.google.co.th/trends/explore?date=2008-12-12%202021-12-12&geo=TH&q=%E0%B8%84%E0%B8%A3%E0%B8%B5%E0%B8%A1%E0%B8%81%E0%B8%B1%E0%B8%99%E0%B9%81%E0%B8%94%E0%B8%94)

FAQ about Google Trends data. (n.d.). Retrieved December 14, 2021, from [https://support.google.com/trends/answer/4365533?hl=en](https://support.google.com/trends/answer/4365533?hl=en)

Rogers, S. (2016, July 1). _What is Google Trends data - and what does it mean?_ Medium. Retrieved December 14, 2021, from https://medium.com/google-news-lab/what-is-google-trends-data-and-what-does-it-mean-b48f07342ee8. 

**Participation Declaration**

<span style="text-decoration:underline;">6205593 Kanitnuch Kerdted</span>: Reported the patterns of all ACF and PACF plots. Wrote the introduction, conclusion, and edited the overall report.

<span style="text-decoration:underline;">6205609 Saran Pannasuriyaporn</span>: Performed EDA, built the models, and analyzed the results. Wrote the report.

<span style="text-decoration:underline;">6205712 Pornnapa Songsiripun</span>: Found and reported AIC for the ARIMA models.
