# Combine

#### _Example_
`let items: [Int] = [1,2,3,4,5,6,7,8,9,10]`
### CurrentValueSubject
- Replace a publisher variable with the CurrentValueSubject
- `let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")`
### PassthroughSubject
- That works the exact same way as CurrentValueSubject except it don't hold stating value
- `let passThrounghPublisher = PassthroughSubject<String, Error>()`
### Sequence Operation
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

### Mathematic Operation
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

### Filter / Reducing Operation
###### **1. MAP**
            .map()
            .tryMap()
###### **2. COMPACT MAP**
            .compactMap()
            .tryCompactMap()
###### **3. FILTER**
            .filter()
            .tryFilter()
###### **4. REMOVE DUPLICATE**
            .removeDuplicates()
            .removeDuplicates(by: )
            .tryRemoveDuplicates(by: )
###### **5. REPLACE**
            .replaceNil(with: )
            .replaceError(with: )
            .replaceEmpty(with: )
###### **6. REDUCE**
            .reduce(, )
            .tryReduce(, )
###### **7. SATISFY**
            .allSatisfy()
            .tryAllSatisfy()
###### **8. COLLECTION**
            .collect()
            .collect(Int)
            .collect(Publishers.TimeGroupingStrategy<Scheduler>)
<details>
<summary>CODE</summary>

```
//MARK: - Filter / Reducing Operation

        // MAP
            .map({ String($0) })
            .tryMap({ int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return String(int)
            })
        /// It the same tryMap but in with additional we will return a value
            .compactMap({ int in
                if 2 < int && int <= 8 {
                    return nil
                }
                return String(int)
            })
        /// 1,2,9,10
        
        // COMPACT MAP
            .tryCompactMap({ int in
                if int == 3 {
                    return nil
                }

                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return String(int)
            })
        /// 1,2,4 and URLError
        
        // FILTER
            .filter({ $0 > 5 && $0 < 9 })
        /// 6,7,8
            .tryFilter({ int in
                if int == 6 {
                    throw URLError(.badServerResponse)
                }
                return int % 2 == 0
            })
        /// 2,4 and URLError
        
        // REMOVE DUPLICATES
            .removeDuplicates()
        /// 1,2,3,4,5,6,7,8,9,10
            .removeDuplicates(by: { $0 == $1 })
        /// 1,2,3,4,5,6,7,8,9,10
            .tryRemoveDuplicates(by: { int1, int2 in
                if int1 < int2 {
                    throw URLError(.badServerResponse)
                }
                return (int1 != 0)
            })
        /// 1 and URLError
        
        // REPLACE
        /// Replace nil value with 5 value
            .replaceNil(with: 5)
            .replaceEmpty(with: 5)
        /// We can combine replace with tryMap to replace error with a default value
            .tryMap({ int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return String(int)
            })
            .replaceError(with: String(7))
        /// 1,2,3,4,7
        
        // SCAN
            .scan(3, { existingValue, newValue in
                return existingValue + newValue
            })
        /// We can use this two command lines below to replace for full command line above
            .scan(3, { $0 + $1 })
            .scan(3, +)
        /// 4,6,9,13,18,24,31,39,48,58
        
        // REDUCE
        /// It return final value after plug each value, result of the command line is 58
            .reduce(3, { existingValue, newValue in
                return existingValue + newValue
            })
            .reduce(3, +)
        
        // SATISFY
            .allSatisfy({ $0 < 10 })
        /*
         let targetRange = (-1...100)
         let numbers = [-1, 0, 10, 5]
         numbers.publisher
             .allSatisfy { targetRange.contains($0) }
             .sink { print("\($0)") }

         // Prints: "true"
         */
//            .tryAllSatisfy({ bool in
//                if (bool != 0) {
//                    throw URLError(.badServerResponse)
//                }
//                return (bool != 0)
//            })
        
        // COLECTION
        /// Nó sẽ trả về một lúc nhiều giá trị tuỳ thuộc mình chỉ định trong collect
        /// Và ta phải đặt nó sau map khi đó mứi có tác dụng
            .map({ String($0) })
        /// Nó sẽ trả về kiểu mảng vì vậy mình có thể gán = thay về append như từng phần tử
            .collect()
        /// Nó sẽ trả về cùng lúc 2 phần tử
            .collect(2)
```
</details>


