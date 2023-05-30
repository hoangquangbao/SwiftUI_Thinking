# Combine

##### CurrentValueSubject
- Replace a publisher variable with the CurrentValueSubject
- `let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")`
##### PassthroughSubject
- That works the exact same way as CurrentValueSubject except it don't hold stating value
- `let passThrounghPublisher = PassthroughSubject<String, Error>()`
