# Upper Confidence Bound

# Import the dataset
dataset = read.csv('Ads_CTR_Optimisation.csv')

#implementing UCB
N = 10000
d = 10
total_reward = 0
ads_selected = integer() #vector of 10,000 showing ad selected at each round
numbers_of_selections = integer(d) # num times ad was selected. Consider for each ad "i"
sums_of_rewards = integer(d) #summin up reward for each ad after each round "n"

for(n in 1:N){
  ad = 0
  max_upper_bound = 0
  
  for(i in 1:d){
    
    if(numbers_of_selections[i] > 0){
    #sum rewards of i up to n divided by number of times the ad i was selected up to round n
    average_reward = sums_of_rewards[i] / numbers_of_selections[i]
    #delta n of i = sqrt(3/2 *log(n) / num selections(i))
    delta_i = sqrt(3/2 * log(n) / numbers_of_selections[i]) #confidence interval
    upper_bound = average_reward + delta_i #upper bound for each ad at round n
   
     } else{
      upper_bound = 1e400
    }
    
    if(upper_bound > max_upper_bound){
      max_upper_bound = upper_bound
      ad = i
    }
  }
  ads_selected = append(ads_selected, ad)
  numbers_of_selections[ad] = numbers_of_selections[ad] + 1 #keeps count
  sums_of_rewards #add the reward given at round n using value at "coordinates"
  reward = dataset[n, ad]
  sums_of_rewards[ad] = sums_of_rewards[ad] + reward
  total_reward = total_reward + reward #reward sum after all 10,000 rounds
}
 
# Visualizing the results
hist(ads_selected,
     col = 'blue',
     main = 'Hist of ad selected',
     xlab = 'ads',
     ylab = '#times ad selected')