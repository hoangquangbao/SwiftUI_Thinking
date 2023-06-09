# Sheet 🛠

👉 You can custom Sheet size with ".presentationDetents"

#### Some notable command lines:

##### 1. hidden drag indicator 
`.presentationDragIndicator(.hidden)`
##### 2. disable dismiss sheet
`.interactiveDismissDisabled(true)`
##### 3. custom Sheet size 
`.presentationDetents([.medium, .large])`
##### 4. custom Sheet size using height
`.presentationDetents([.height(100), .medium, .large])`
##### 5. custom Sheet size using fraction
*<sub>-> `fraction` follows scale so use it is better than `height`</sub>*

`.presentationDetents([.fraction(0.23456), .medium, .large])`
