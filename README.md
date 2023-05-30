# Combine

#### _Example_
`let items: [Int] = Array(1..<11)`
##### CurrentValueSubject
- Replace a publisher variable with the CurrentValueSubject
- `let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")`
##### PassthroughSubject
- That works the exact same way as CurrentValueSubject except it don't hold stating value
- `let passThrounghPublisher = PassthroughSubject<String, Error>()`
##### Sequence Operation
###### **1. FIRST**
            .first()
            .first(where: )
            .tryFirst(where: )
###### **2. LAST**
            .last()
            .last(where: )
            .tryLast(where: )
###### **3. DROP**
            .dropFirst()
            .drop(while: )
            .tryDrop(while: )
            .drop(untilOutputFrom: )
###### **4. PREFIT**
            .prefix()
            .prefix(while: )
            .tryPrefix(while: )
            .prefix(untilOutputFrom: )
###### **5. OUTPUT**
            .output(at: )
            .output(in: )
<details>
<summary>CODE</summary>

```
        //MARK: - Sequence Operation
        
        // FIRST
            .first()
            .first(where: {  $0 > 8 })
        /// If conditionals come before then publisher emit that value
            .tryFirst(where: { int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return int > 7
            })
        
        // LAST
            .last()
            .last(where: { int in
                int > 3
            })
        /// It will through to the end of the array before return a value
            .tryLast(where: { int in
                if int == 6 {
                    throw URLError(.badServerResponse)
                }
                return int > 4
            })
        
        // DROP: Loại những value thoả điều kiện
            .dropFirst()
        /// 1
            .dropFirst(5)
        /// 6,7,8,9,10
            .drop(while: { $0 < 5 })
        /// 5,6,7,8,9,10
            .tryDrop(while: { int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return int < 8
            })
        /// printf URLError
        
        // PREFIT: Lấy những giá trị thoả điều kiện
            .prefix(6)
        /// 1,2,3,4,5,6
            .prefix(while: { $0 < 5 })
        /// 1,2,3,4
            .tryPrefix(while: { int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return int < 8
            })
        /// 1,2,3,4 and URLError
        
        // OUTPUT
            .output(at: 4)
        /// 5
            .output(in: 2...6)
        /// 3,4,5,6,7
```
</details>

##### Mathematic Operation
###### **1. MAX**
            .max()
            .max(by: )
            .tryMax(by: )
###### **2. MIN**
            .min()
            .min(by: )
            .tryMin(by: )
<details>
<summary>CODE</summary>

```
        //MARK: - Mathematic Operation
            
        // MAX
            .max()
            .max(by: {  $0 < $1 })
            .tryMax(by: { int1, int2 in
                if int1 == 5 {
                    throw URLError(.badServerResponse)
                }
                return int1 < int2
            })
        
        // MIN
            .min()
            .min(by: { $0 < $1 })
            .tryMin(by: { int1, int2 in
                if int1 == 5 {
                    throw URLError(.badServerResponse)
                }
                return int1 < int2
            })
```
</details>




