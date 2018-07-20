# Thompson Sampling

dataset = read.csv('Ads_CTR_Optimisation.csv')

#implementing Thompson Sampling
N = 10000
d = 10
total_reward = 0
numbers_of_rewards_1 = integer(d)
numbers_of_rewards_0 = integer(d)
ads_selected = integer(0) #vector of 10,000 showing ad selected at each round

for(n in 1:N){
  ad = 0
  max_random= 0
  
  for(i in 1:d){
    
   random_beta = rbeta(n = 1,
                       shape1 = numbers_of_rewards_1[i] + 1,
                       shape2 = numbers_of_rewards_0[i] + 1)
    
    if(random_beta > max_random){
      max_random = random_beta
      ad = i
    }
  }
  ads_selected = append(ads_selected, ad)
  reward = dataset[n, ad]
  #incremented when certain ad is rewarded (either 1 or zed)
  if( reward == 1){
    numbers_of_rewards_1[ad] = numbers_of_rewards_1[ad] + 1
  }
  else{
    numbers_of_rewards_0[ad] = numbers_of_rewards_0[ad] + 1
  }
  total_reward = total_reward + reward #reward sum after all 10,000 rounds
}

# Visualizing the results
hist(ads_selected,
     col = 'blue',
     main = 'Hist of ad selected',
     xlab = 'ads',
     ylab = '#times ad selected')