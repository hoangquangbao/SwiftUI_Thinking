//
//  GridViewBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Bao Hoang on 20/10/24.
//

/*
 .gridCellColumns(<#T##Int#>)
 .gridCellAnchor(<#T##UnitPoint#>)
 .gridColumnAlignment(<#T##HorizontalAlignment#>)
 .gridCellUnsizedAxes(<#T##Axis.Set#>)
 */

import SwiftUI

struct GridViewBootcamp: View {
    var body: some View {
//        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
//            GridRow() {
//                cell(int: 1)
//                cell(int: 2)
//                cell(int: 3)
//                cell(int: 4)
//            }
//            
//            Divider()
//                .gridCellUnsizedAxes(.horizontal)
//
//            GridRow() {
//                cell(int: 5)
//                cell(int: 6)
//            }
//        }
        
        Grid(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {
            ForEach(0..<5) { row in
                GridRow() {
                    ForEach(0..<5) { col in
                        let cellNumber = row * 5 + col + 1
                        
                        if cellNumber == 20 {
                            EmptyView()
                            /*
                            Color.red
                                //Fix cell size
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                            //OR
                            cell(int: cellNumber)
                                .hidden()
                             */
                        } else {
                            cell(int: cellNumber)
                            //Get spacing for a cell
                                .gridCellColumns(cellNumber == 19 ? 2 : 1)
                        }
                    }
                }
            }
        }
    }
    
    private func cell(int: Int) -> some View {
        Text("\(int)")
            .frame(width: 50, height: 50, alignment: .center)
            .background(Color.green)
            .foregroundColor(.white)
            .fontWeight(.bold)
    }
}

#Preview {
    GridViewBootcamp()
}
