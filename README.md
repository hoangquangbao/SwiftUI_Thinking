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
            .first(where: <#T##(Int) -> Bool#>)
            .tryFirst(where: <#T##(Publishers.First<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
###### **2. LAST**
            .last()
            .last(where: <#T##(Int) -> Bool#>)
            .tryLast(where: <#T##(Publishers.Last<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
###### **3. DROP**
            .dropFirst()
            .drop(while: <#T##(Int) -> Bool#>)
            .tryDrop(while: <#T##(Publishers.Drop<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
            .drop(untilOutputFrom: <#T##Publisher#>)
###### **4. PREFIT**
            .prefix(<#T##maxLength: Int##Int#>)
            .prefix(while: <#T##(Int) -> Bool#>)
            .tryPrefix(while: <#T##(Publishers.Output<PassthroughSubject<Int, Error>>.Output) throws -> Bool#>)
            .prefix(untilOutputFrom: <#T##Publisher#>)
###### **5. OUTPUT**
            .output(at: <#T##Int#>)
            .output(in: <#T##RangeExpression#>)
<details>
<summary>Code</summary>

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



