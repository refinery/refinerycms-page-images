@refinerycms @pages @pages-manage @page-images
Feature: Attach Page Images
  In order to control the content on my website
  As an administrator
  I want to create and manage page images

  Background:
    Given I am a logged in refinery user
    And I have pages titled Home, About
    When I go to the list of pages
    And I follow "Edit this page"

  Scenario: Page Edit Shows Images Tab
    Then I should see "Images" within "#custom_images_tab"

  Scenario: Add Image Button appears
    Then I should see "Add Image"