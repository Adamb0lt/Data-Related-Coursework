# -*- coding: utf-8 -*-
"""
Created on Fri Mar 17 01:15:07 2023

@author: adwal
"""
import random
statCap = [
    {'State': 'Alabama', 'Capital': 'Montgomery'},
    {'State': 'Alaska', 'Capital': 'Juneau'},
    {'State': 'Arizona', 'Capital': 'Phoenix'},
    {'State': 'Arkansas', 'Capital': 'Little Rock'},
    {'State': 'California', 'Capital': 'Sacramento'},
    {'State': 'Colorado', 'Capital': 'Denver'},
    {'State': 'Connecticut', 'Capital': 'Hartford'},
    {'State': 'Delaware', 'Capital': 'Dover'},
    {'State': 'Florida', 'Capital': 'Tallahassee'},
    {'State': 'Georgia', 'Capital': 'Atlanta'},
    {'State': 'Hawaii', 'Capital': 'Honolulu'},
    {'State': 'Idaho', 'Capital': 'Boise'},
    {'State': 'Illinois', 'Capital': 'Springfield'},
    {'State': 'Indiana', 'Capital': 'Indianapolis'},
    {'State': 'Iowa', 'Capital': 'Des Moines'},
    {'State': 'Kansas', 'Capital': 'Topeka'},
    {'State': 'Kentucky', 'Capital': 'Frankfort'},
    {'State': 'Louisiana', 'Capital': 'Baton Rouge'},
    {'State': 'Maine', 'Capital': 'Augusta'},
    {'State': 'Maryland', 'Capital': 'Annapolis'},
    {'State': 'Massachusetts', 'Capital': 'Boston'},
    {'State': 'Michigan', 'Capital': 'Lansing'},
    {'State': 'Minnesota', 'Capital': 'Saint Paul'},
    {'State': 'Mississippi', 'Capital': 'Jackson'},
    {'State': 'Missouri', 'Capital': 'Jefferson City'},
    {'State': 'Montana', 'Capital': 'Helena'},
    {'State': 'Nebraska', 'Capital': 'Lincoln'},
    {'State': 'Nevada', 'Capital': 'Carson City'},
    {'State': 'New Hampshire', 'Capital': 'Concord'},
    {'State': 'New Jersey', 'Capital': 'Trenton'},
    {'State': 'New Mexico', 'Capital': 'Santa Fe'},
    {'State': 'New York', 'Capital': 'Albany'},
    {'State': 'North Carolina', 'Capital': 'Raleigh'},
    {'State': 'North Dakota', 'Capital': 'Bismarck'},
    {'State': 'Ohio', 'Capital': 'Columbus'},
    {'State': 'Oklahoma', 'Capital': 'Oklahoma City'},
    {'State': 'Oregon', 'Capital': 'Salem'},
    {'State': 'Pennsylvania', 'Capital': 'Harrisburg'},
    {'State': 'Rhode Island', 'Capital': 'Providence'},
    {'State': 'South Carolina', 'Capital': 'Columbia'},
    {'State': 'South Dakota', 'Capital': 'Pierre'},
    {'State': 'Tennessee', 'Capital': 'Nashville'},
    {'State': 'Texas', 'Capital': 'Austin'},
    {'State': 'Utah', 'Capital': 'Salt Lake City'},
    {'State': 'Vermont', 'Capital': 'Montpelier'},
    {'State': 'Virginia', 'Capital': 'Richmond'},
    {'State': 'Washington', 'Capital': 'Olympia'},
    {'State': 'West Virginia', 'Capital': 'Charleston'},
    {'State': 'Wyoming', 'Capital': 'Madison'},
    {'State': 'Wisconsin', 'Capital': 'Cheyenne'}]



#Shuffle the list for randomness
random.shuffle(statCap)

#Correct and incorrect
correct = 0
misses = 0

#Ask the user for the capital of each state
for state in statCap:
# Prompt the user for the capital of the state
    capital = input("What is the capital of " + state['State'] + "? ")
# Check if the user's input is correct
    if capital.lower() == state['Capital'].lower():
        correct += 1
        print("Correct!")
    else:
        misses += 1
        print("Incorrect. The capital of", state['State'], "is", state['Capital'] + ".")
#Display the results
print("")
print("Results:")
print("Correct: ", correct)
print("Misses: ", misses)
    
