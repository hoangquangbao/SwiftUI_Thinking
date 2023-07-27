# Combine 🔢

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

### Timing Operation
###### **1. DEBOUND**
            .debounce(for: , scheduler: )     
###### **2. DELAY**
            .delay(for: , scheduler: )
###### **3. MEASURE INTERVAL**
            /// measureInterval must works with Map Stride as below
            .measureInterval(using: DispatchQueue.main)
            .map({ stride in
                return "\(stride.timeInterval)"
            })
###### **4. THROTTLE**
            .throttle(for: , scheduler: , latest: )
###### **5. RETRY**
            .retry(Int)
###### **6. TIMEOUT**
            .timeout(, scheduler: )
<details>
<summary>CODE</summary>
            
```
        //MARK: - Timing Operations
        
        // DEBOUND
        /// Thời gian bắt đầu đếm tính từ lần xuất bản cuối cùng.
        /// VD: xuất bản ở giây 0.25 thì 2 giây sau nó mới đẩy đi
        /// Trong vòng 2 giây đó: có giá trị mới thì xuất bản giá trị đó. Sau đó bắt đầu đếm lại.
        /// Không có giá trị mới thì xuất bản giá trị cuói cùng
         /*
          Example:
          let bounces:[(Int,TimeInterval)] = [
              (0, 0),
              (1, 0.25),  // 0.25s interval since last index
              (2, 1),     // 0.75s interval since last index
              (3, 1.25),  // 0.25s interval since last index
              (4, 1.5),   // 0.25s interval since last index
              (5, 2)      // 0.5s interval since last index
          ]

          let subject = PassthroughSubject<Int, Never>()
          cancellable = subject
              .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
              .sink { index in
                  print ("Received index \(index)")
              }

          for bounce in bounces {
              DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
                  subject.send(bounce.0)
              }
          }

          // Prints:
          //  Received index 1
          //  Received index 4
          //  Received index 5

          //  Here is the event flow shown from the perspective of time, showing value delivery through the `debounce()` operator:

          //  Time 0: Send index 0.
          //  Time 0.25: Send index 1. Index 0 was waiting and is discarded.
          //  Time 0.75: Debounce period ends, publish index 1.
          //  Time 1: Send index 2.
          //  Time 1.25: Send index 3. Index 2 was waiting and is discarded.
          //  Time 1.5: Send index 4. Index 3 was waiting and is discarded.
          //  Time 2: Debounce period ends, publish index 4. Also, send index 5.
          //  Time 2.5: Debounce period ends, publish index 5.
          */
         /// Với các giá trị khác thì nên set theo giá trị lớn nhất
            .debounce(for: 2, scheduler: DispatchQueue.main)
        
        // DELAY
            .delay(for: 5, scheduler: DispatchQueue.main)
        
        // MEASURE INTERVAL
        /// measureInterval must be works with Map Stride as below
            .measureInterval(using: DispatchQueue.main)
            .map({ stride in
                return "\(stride.timeInterval)"
            })
        
        // THROTTLE
        /// Inteval of each publisher
        /// Thời gian được tỉnh từ ban đầu, không phụ thuộc vào lần xuất bản cuối như debound. Đây là sự khác nhau giữa hai cái.
        /// latest:
        ///  - true: Đúng thời gian 3s mà không có phần tử nào thì lấy phần tử cuối cùng
        ///  - false: Đúng thời gian 3s mà không có phần tử nào thì lấy phần tử đầu tiên nhận được
            .throttle(for: 1.5, scheduler: DispatchQueue.main, latest: true)
        
        // RETRY
        /// While get data from API, if error then we will special times retry request.
            .retry(3)
        
        // TIMEOUT
        /// This is waiting inteval before start publisher
        /// EX: We set delay is 5 senconds then we will not get anything values because timeout is 4 seconds
        /// .delay(for: 5, scheduler: DispatchQueue.main)
        /// .timeout(4, scheduler: DispatchQueue.main)
            .timeout(0.3, scheduler: DispatchQueue.main)
            
```
</details>

### Multiple Publishers / Subscribers
###### **1. COMPACT**
            .combineLatest()
            .compactMap()
###### **2. MERGE**
            .merge(with: Publisher)
###### **3. ZIP**
            .zip(Publisher)
            .map({ tuple in
                
            })
###### **4. TRYMAP / CATCH**
            .tryMap({ Int in
                
            })
            .catch({  in
                
            })
            
<details>
<summary>CODE</summary>
            
```
        // MARK: - Multiple Publishers / Subscribers
        
        // COMPACT
         /// Combine many Publisher together
         /// After that use compactMap to show it
//            .combineLatest(dataService.boolPublisher, dataService.intPublisher)
//            .compactMap({ (int1, bool, int2) in
//                if bool {
//                    return String(int1)
//                }
//                return int2
//            })
         /// Rút gọn code
            .compactMap({ $1 ? String($0) : String($2) })
            .removeDuplicates()
        
        // MERGE
        /// Merger result of publisher and requires of type is  equivalent
        /// Int with Int, Bool with Bool, Double with Double,...
            .merge(with: dataService.intPublisher)
        /// Result: 1,2,3,4,5,6,888,7,888,8,888,9,10
        
        // ZIP
        /// Zip dùng để kết hợp kêt quả của nhiều publisher lại với nhau theo từng bộ sau đó publish a tuples.
        /// Sau đó ta dùng map (tuple đại diện) để show ra cái đó.
        /// Số phần tử thu được sẽ = với số lượng publisher ít nhất.
        /// Chỉ publisher khi tất các Publishers emits an event.
        /// Nếu bất kì publisher nào kết thúc thành công hay fails thì zip nó cũng sẽ có kết quả tương ứng
        /// If any upstream publisher finishers successfully or fails with an error, so too does the zipped publisher.
        /// Như ex: Dù là i > 4 && i < 8 = 5,6,7 thì = true, còn lại = false và ta chỉ zip cái giá trị bool nên nó sẽ in ra đủ 10 bộ
//            .zip(dataService.boolPublisher)
//            .map({ tuple in
//                return String(tuple.0) + tuple.1.description
//            })
        /// Ngược lại, như ví dụ dưới:
        /// ex: i > 4 && i < 8 = 5,6,7 và ta zip cả int nên kết quả thu được chỉ có 3 elements
            .zip(dataService.boolPublisher, dataService.intPublisher)
//            .map({ (int, bool) in
//                if bool {
//                    return String(int)
//                }
//                return "n/a"
//            })
        /// or
            .map({ tuple in
                return String(tuple.0) + " " + tuple.1.description + " " + String(tuple.2)
            })
        
        // TRY MAP / CATCH
        /// Will print 1,2,3,4 and when = 5 it will be got URLError
        /// If URLError will be print intPublisher
        /// Because intPublisher had 3 lements (i > 4 && i < 8 = 5,6,7)
        /// So result: 1,2,3,4,888,888,888
            .tryMap({ int in
                if int == 5 {
                    throw URLError(.badServerResponse)
                }
                return int
            })
            .catch({ error in
                return self.dataService.intPublisher
            })
         

```
</details>          
