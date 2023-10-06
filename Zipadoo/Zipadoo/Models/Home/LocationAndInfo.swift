//
//  FriendsLocation.swift
//  Zipadoo
//
//  Created by Handoo Jeong on 2023/09/21.
//

import Foundation
import MapKit

struct LocationAndInfo: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let imgString: String
    let isMe: Bool
}
