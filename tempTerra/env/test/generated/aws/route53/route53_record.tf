resource "aws_route53_record" "tfer--Z07504443JVPXGFZGQJIF__8321e49a2bc104d624d1c47e8cc2e15a-002E-jpheymann-002E-com-002E-_CNAME_" {
  multivalue_answer_routing_policy = "false"
  name                             = "_8321e49a2bc104d624d1c47e8cc2e15a.jpheymann.com"
  records                          = ["_a1d9e6b9c4d3cac343d832eea124ce33.djqtsrsxkq.acm-validations.aws."]
  ttl                              = "300"
  type                             = "CNAME"
  zone_id                          = "${aws_route53_zone.tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com.zone_id}"
}

resource "aws_route53_record" "tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com-002E-_A_" {
  alias {
    evaluate_target_health = "false"
    name                   = "dda8gjfj4yfn9.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
  }

  multivalue_answer_routing_policy = "false"
  name                             = "jpheymann.com"
  type                             = "A"
  zone_id                          = "${aws_route53_zone.tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com.zone_id}"
}

resource "aws_route53_record" "tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com-002E-_NS_" {
  multivalue_answer_routing_policy = "false"
  name                             = "jpheymann.com"
  records                          = ["ns-125.awsdns-15.com.", "ns-1341.awsdns-39.org.", "ns-1721.awsdns-23.co.uk.", "ns-810.awsdns-37.net."]
  ttl                              = "172800"
  type                             = "NS"
  zone_id                          = "${aws_route53_zone.tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com.zone_id}"
}

resource "aws_route53_record" "tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com-002E-_SOA_" {
  multivalue_answer_routing_policy = "false"
  name                             = "jpheymann.com"
  records                          = ["ns-1341.awsdns-39.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl                              = "900"
  type                             = "SOA"
  zone_id                          = "${aws_route53_zone.tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com.zone_id}"
}

resource "aws_route53_record" "tfer--Z07504443JVPXGFZGQJIF_www-002E-jpheymann-002E-com-002E-_A_" {
  alias {
    evaluate_target_health = "false"
    name                   = "dda8gjfj4yfn9.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
  }

  multivalue_answer_routing_policy = "false"
  name                             = "www.jpheymann.com"
  type                             = "A"
  zone_id                          = "${aws_route53_zone.tfer--Z07504443JVPXGFZGQJIF_jpheymann-002E-com.zone_id}"
}
