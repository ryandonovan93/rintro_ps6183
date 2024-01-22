# Conducting a paired-samples t-test.  ------------------------------------
#Author: Ryan Donovan (ryan.donovan@universityofgalway.ie)
#Dataset: sleep dataset taken from base R


# Step 1: View the Dataset ------------------------------------------------

print(sleep)

# Step 2: Calculate descriptive statistics --------------------------------

#summary(sleep)

aggregate(sleep, extra ~ group, FUN = mean) #the aggregate function enables you to compute
#descriptive statistics per sub-groups.

# Step 3: Run paired-samples t-test

t.test(sleep$extra[sleep$group == 1],

       sleep$extra[sleep$group == 2],

       paired = TRUE)

# Step 4: Generate Box-Plot


plot(sleep$group, sleep$extra, xlab = "Treatment", ylab = "Hours of Sleep",
     main = "Effect of Treament on Sleep Duration")

