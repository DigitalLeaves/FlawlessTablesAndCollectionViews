//
//  ImagesAndTextsModel.swift
//  iOSLazyImageLoad
//
//  Created by Ignacio Nieto Carvajal on 7/2/16.
//  Copyright © 2016 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

let kLazyLoadPlaceholderImage = UIImage(named: "placeholder")!

let kLazyLoadTexts = [
    "Sed posuere consectetur est at lobortis. Donec id elit non mi porta gravida at eget metus. Etiam porta sem malesuada magna mollis euismod. Maecenas sed diam eget risus varius blandit sit amet non magna.",
    "Cras mattis consectetur purus sit amet fermentum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Nullam id dolor id nibh ultricies vehicula ut id elit. Donec sed odio dui. Curabitur blandit tempus porttitor.",
    "Vestibulum id ligula porta felis euismod semper. Vestibulum id ligula porta felis euismod semper. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Nullam quis risus eget urna mollis ornare vel eu leo. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.",
    "Nullam id dolor id nibh ultricies vehicula ut id elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras mattis consectetur purus sit amet fermentum.",
    "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam porta sem malesuada magna mollis euismod. Donec id elit non mi porta gravida at eget metus. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
    "Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis. Donec id elit non mi porta gravida at eget metus. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec ullamcorper nulla non metus auctor fringilla. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.",
    "Curabitur blandit tempus porttitor. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec sed odio dui. Maecenas faucibus mollis interdum.",
    "Aenean lacinia bibendum nulla sed consectetur. Vestibulum id ligula porta felis euismod semper. Sed posuere consectetur est at lobortis. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec id elit non mi porta gravida at eget metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam eget risus varius blandit sit amet non magna.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam porta sem malesuada magna mollis euismod. Maecenas sed diam eget risus varius blandit sit amet non magna. Curabitur blandit tempus porttitor. Aenean lacinia bibendum nulla sed consectetur. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.",
    "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Nulla vitae elit libero, a pharetra augue. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla vitae elit libero, a pharetra augue.",
    "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec id elit non mi porta gravida at eget metus. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Nulla vitae elit libero, a pharetra augue. Etiam porta sem malesuada magna mollis euismod.",
    "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Sed posuere consectetur est at lobortis. Vestibulum id ligula porta felis euismod semper. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Cras mattis consectetur purus sit amet fermentum. Maecenas faucibus mollis interdum. Aenean lacinia bibendum nulla sed consectetur.",
    "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas faucibus mollis interdum. Nullam quis risus eget urna mollis ornare vel eu leo. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod.",
    "Aenean lacinia bibendum nulla sed consectetur. Aenean lacinia bibendum nulla sed consectetur. Vestibulum id ligula porta felis euismod semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Donec sed odio dui. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras mattis consectetur purus sit amet fermentum. Donec id elit non mi porta gravida at eget metus.",
    "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec id elit non mi porta gravida at eget metus. Cras mattis consectetur purus sit amet fermentum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.",
    "Donec ullamcorper nulla non metus auctor fringilla. Curabitur blandit tempus porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id ligula porta felis euismod semper.",
    "Nullam id dolor id nibh ultricies vehicula ut id elit. Donec ullamcorper nulla non metus auctor fringilla. Sed posuere consectetur est at lobortis. Maecenas sed diam eget risus varius blandit sit amet non magna. Maecenas faucibus mollis interdum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
]

let kLazyLoadImages = [
        "https://farm2.staticflickr.com/1693/24234208004_2d4694b687_b.jpg",
        "https://farm2.staticflickr.com/1556/24235516853_44171ffc52_b.jpg",
        "https://farm2.staticflickr.com/1459/24494771709_b7be8cb123_b.jpg",
        "https://farm2.staticflickr.com/1602/24494772549_03ed2deb2d_b.jpg",
        "https://farm2.staticflickr.com/1707/24566902550_78e30c0c4d_b.jpg",
        "https://farm2.staticflickr.com/1692/24566903340_f911640dfa_b.jpg",
        "https://farm2.staticflickr.com/1445/24566903960_b9f77dac96_b.jpg",
        "https://farm2.staticflickr.com/1664/24744488912_af63cb39e6_b.jpg",
        "https://farm2.staticflickr.com/1511/24744489922_7dce4e33e1_b.jpg",
        "https://farm2.staticflickr.com/1483/24744490022_4c3faf13a5_b.jpg",
        "https://farm2.staticflickr.com/1609/24768930091_ef68aaefe2_b.jpg",
        "https://farm2.staticflickr.com/1521/24768930291_1cd0d23d2f_b.jpg",
        "https://farm2.staticflickr.com/1567/24836101616_0fca0ce6e6_b.jpg",
        "https://farm2.staticflickr.com/1502/24836102206_c208a27c6f_b.jpg",
        "https://farm2.staticflickr.com/1637/24836102226_eec65e998d_b.jpg",
        "https://farm2.staticflickr.com/1601/24836102396_0cfc591c68_b.jpg",
        "https://farm2.staticflickr.com/1508/24836102466_c89516603a_b.jpg",
        "https://farm2.staticflickr.com/1614/24862369735_0ca9d131d4_b.jpg",
        "https://farm2.staticflickr.com/1663/24862370295_43078437a7_b.jpg"
]

