#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Tests for `ptct` package."""

import pytest
import unittest

from ptct import ptct


@pytest.fixture
def error_fixture():
    assert 0


class TestPtct(unittest.TestCase):
    """Tests for `ptct` package."""

    def setUp(self):
        """Set up test fixtures, if any."""

    def tearDown(self):
        """Tear down test fixtures, if any."""

    def test_f_to_r(self):
        """Test something."""
        assert int(ptct.convert(84.2, 'F', 'R')) == int(543.5)
