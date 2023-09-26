--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0 (Debian 14.0-1.pgdg110+1)
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO sa;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO sa;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO sa;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO sa;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO sa;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO sa;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO sa;

--
-- Name: client; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO sa;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO sa;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO sa;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO sa;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO sa;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO sa;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO sa;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO sa;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO sa;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO sa;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO sa;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO sa;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO sa;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO sa;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO sa;

--
-- Name: component; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO sa;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO sa;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO sa;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO sa;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO sa;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO sa;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO sa;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO sa;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO sa;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO sa;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO sa;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO sa;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO sa;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO sa;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO sa;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO sa;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO sa;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO sa;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO sa;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO sa;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO sa;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO sa;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO sa;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO sa;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO sa;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO sa;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO sa;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO sa;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO sa;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO sa;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO sa;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO sa;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO sa;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO sa;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO sa;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO sa;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO sa;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO sa;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO sa;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO sa;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO sa;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO sa;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO sa;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO sa;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO sa;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO sa;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO sa;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO sa;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO sa;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO sa;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO sa;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO sa;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO sa;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO sa;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO sa;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO sa;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO sa;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO sa;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO sa;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO sa;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO sa;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO sa;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO sa;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO sa;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO sa;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO sa;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO sa;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO sa;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO sa;

--
-- Name: vehicle; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.vehicle (
    id integer NOT NULL,
    description character varying(8192),
    energy integer,
    name character varying(255),
    type integer,
    ascent double precision,
    auxiliary_consumption double precision,
    charging_curve character varying(255),
    charging_setup_duration integer,
    connector_type character varying(255),
    descent double precision,
    free_flow_speed_table character varying(255),
    max_charge double precision,
    max_charging_current double precision,
    max_charging_voltage double precision,
    trafic_speed_table character varying(255)
);


ALTER TABLE public.vehicle OWNER TO sa;

--
-- Name: vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.vehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vehicle_id_seq OWNER TO sa;

--
-- Name: vehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.vehicle_id_seq OWNED BY public.vehicle.id;


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO sa;

--
-- Name: vehicle id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.vehicle ALTER COLUMN id SET DEFAULT nextval('public.vehicle_id_seq'::regclass);


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
0b844abc-8eb6-438e-97a4-c7dae2be43f1	\N	auth-cookie	master	aeef319a-966f-47fa-91a5-4e611ee296fc	2	10	f	\N	\N
af63c204-704c-4011-803b-4405d662589b	\N	auth-spnego	master	aeef319a-966f-47fa-91a5-4e611ee296fc	3	20	f	\N	\N
8fa86946-c7a1-4a6e-ae99-0c041f947014	\N	identity-provider-redirector	master	aeef319a-966f-47fa-91a5-4e611ee296fc	2	25	f	\N	\N
51acee5f-d6f7-4d7f-86e5-1250a3bbb68b	\N	\N	master	aeef319a-966f-47fa-91a5-4e611ee296fc	2	30	t	c0004148-6fc7-4284-85fa-5c7eb3ecdef3	\N
69faf155-07e5-4605-8852-6ad0668d76e9	\N	auth-username-password-form	master	c0004148-6fc7-4284-85fa-5c7eb3ecdef3	0	10	f	\N	\N
b07ca041-1c9e-4ae5-9abc-871bb8a1c8ce	\N	\N	master	c0004148-6fc7-4284-85fa-5c7eb3ecdef3	1	20	t	b9eef15d-ea41-43b0-a45b-196561e6e2ee	\N
b13f5117-3915-4634-9a16-636572a64096	\N	conditional-user-configured	master	b9eef15d-ea41-43b0-a45b-196561e6e2ee	0	10	f	\N	\N
4a028e0f-a032-4479-a127-032122a49454	\N	auth-otp-form	master	b9eef15d-ea41-43b0-a45b-196561e6e2ee	0	20	f	\N	\N
e901a277-df35-4e7e-b7bb-2dcc7ab6011f	\N	direct-grant-validate-username	master	574ebbc1-bc28-47a9-9632-56a6941c10e0	0	10	f	\N	\N
9ac0f313-6c64-42c1-b0a7-84f6cf0cf2ec	\N	direct-grant-validate-password	master	574ebbc1-bc28-47a9-9632-56a6941c10e0	0	20	f	\N	\N
7480cc07-7691-429e-980f-fe3ccc4fe964	\N	\N	master	574ebbc1-bc28-47a9-9632-56a6941c10e0	1	30	t	cdae0532-683c-4f07-b674-15c3c2c39bcb	\N
a1e9b424-6fce-48b9-998e-22e6146d21a1	\N	conditional-user-configured	master	cdae0532-683c-4f07-b674-15c3c2c39bcb	0	10	f	\N	\N
729008d7-2934-4688-9c47-2631c58b8441	\N	direct-grant-validate-otp	master	cdae0532-683c-4f07-b674-15c3c2c39bcb	0	20	f	\N	\N
7e4b069a-9e76-4844-93d0-1a18607c3960	\N	registration-page-form	master	a3622de3-5d50-47ed-8890-076742bc885f	0	10	t	28dc301f-d3f9-4134-8e42-b107b5d500a3	\N
62ef9f39-f97e-48f8-b7f6-3cba93b48e51	\N	registration-user-creation	master	28dc301f-d3f9-4134-8e42-b107b5d500a3	0	20	f	\N	\N
649bee37-a0bc-4dbb-bbe7-94123f45133b	\N	registration-profile-action	master	28dc301f-d3f9-4134-8e42-b107b5d500a3	0	40	f	\N	\N
6dbee92e-5d58-4a76-ac49-3784d4eb687e	\N	registration-password-action	master	28dc301f-d3f9-4134-8e42-b107b5d500a3	0	50	f	\N	\N
c0e1bfd2-0276-47ff-8b15-d714ee056278	\N	registration-recaptcha-action	master	28dc301f-d3f9-4134-8e42-b107b5d500a3	3	60	f	\N	\N
f14d43b8-6fc1-4196-9fe0-99d4c5fdaf37	\N	reset-credentials-choose-user	master	34cd2989-bfca-4690-87f3-60d3207d5c15	0	10	f	\N	\N
3d1635ab-f5d5-42c4-a92d-ed99c3f9d1d5	\N	reset-credential-email	master	34cd2989-bfca-4690-87f3-60d3207d5c15	0	20	f	\N	\N
81123bac-6b49-4762-af15-f63f5b3f9ae0	\N	reset-password	master	34cd2989-bfca-4690-87f3-60d3207d5c15	0	30	f	\N	\N
8c7c03ca-46c1-4c3e-8159-90062ac5669c	\N	\N	master	34cd2989-bfca-4690-87f3-60d3207d5c15	1	40	t	18b98c16-66b7-451d-9989-586c31f697f0	\N
d5e74038-9a27-4b21-92e1-b325b104f346	\N	conditional-user-configured	master	18b98c16-66b7-451d-9989-586c31f697f0	0	10	f	\N	\N
d5b57fa3-818c-4273-84a4-5d60c0f6e741	\N	reset-otp	master	18b98c16-66b7-451d-9989-586c31f697f0	0	20	f	\N	\N
5e38ccd6-a5d8-452c-b252-10c1cd49908d	\N	client-secret	master	29e706e1-63ab-4e25-8365-42d29710d151	2	10	f	\N	\N
daa928c2-d35f-452b-852b-9da5f1982a51	\N	client-jwt	master	29e706e1-63ab-4e25-8365-42d29710d151	2	20	f	\N	\N
62ed93bc-7bfe-4a96-96ce-a1b98513c977	\N	client-secret-jwt	master	29e706e1-63ab-4e25-8365-42d29710d151	2	30	f	\N	\N
443660e4-f0a1-4002-a0f6-a8124ac04b9e	\N	client-x509	master	29e706e1-63ab-4e25-8365-42d29710d151	2	40	f	\N	\N
73a80a51-1485-4607-be06-93572a01cc06	\N	idp-review-profile	master	e5c18c07-8c6d-46dd-9830-f364a06e8fde	0	10	f	\N	8d7dd784-b7f0-4984-a922-6f91e25ca6bb
8256a578-c921-4de8-b788-6cd80a8f2a7e	\N	\N	master	e5c18c07-8c6d-46dd-9830-f364a06e8fde	0	20	t	2916ba71-7c0b-4c68-b125-c875f93d3bff	\N
9ebb3791-695f-42c8-be77-ed305bb86071	\N	idp-create-user-if-unique	master	2916ba71-7c0b-4c68-b125-c875f93d3bff	2	10	f	\N	39de2fe8-0da1-43d4-9d7f-ac45db380040
aaf07090-8413-4eb2-9a27-58bd5cc8093f	\N	\N	master	2916ba71-7c0b-4c68-b125-c875f93d3bff	2	20	t	d3ac06b8-ddca-467f-81c1-ffbdb3e2be53	\N
fc10df3c-3536-45c5-a59b-d0e08afb16b1	\N	idp-confirm-link	master	d3ac06b8-ddca-467f-81c1-ffbdb3e2be53	0	10	f	\N	\N
0d25a39c-830c-4a50-ab16-6b3e1b130737	\N	\N	master	d3ac06b8-ddca-467f-81c1-ffbdb3e2be53	0	20	t	3d326f4b-23e4-44e6-b51e-c617a46ec5fc	\N
b05929f6-06d5-4825-91fa-fb05414ae8d2	\N	idp-email-verification	master	3d326f4b-23e4-44e6-b51e-c617a46ec5fc	2	10	f	\N	\N
291193bf-7ff0-4983-b626-7bff1f072c50	\N	\N	master	3d326f4b-23e4-44e6-b51e-c617a46ec5fc	2	20	t	5441c2a1-d4ec-47e3-8a17-8d6f9d6ab900	\N
05ba2bff-5af4-4c49-8b8c-dc368a6a216f	\N	idp-username-password-form	master	5441c2a1-d4ec-47e3-8a17-8d6f9d6ab900	0	10	f	\N	\N
3fba11f2-6e72-4a86-ae6f-658ff42b72a5	\N	\N	master	5441c2a1-d4ec-47e3-8a17-8d6f9d6ab900	1	20	t	0559698d-da7b-4e8a-9a0e-c94e88b1a7f1	\N
61311056-ed34-4e8a-a2db-23ea29e02fc2	\N	conditional-user-configured	master	0559698d-da7b-4e8a-9a0e-c94e88b1a7f1	0	10	f	\N	\N
9c28a715-d18c-4d44-957a-69a3ab75c0ea	\N	auth-otp-form	master	0559698d-da7b-4e8a-9a0e-c94e88b1a7f1	0	20	f	\N	\N
6ffcdc98-9e66-4cee-82c5-4aa8b53148e9	\N	http-basic-authenticator	master	04bb5e83-8400-49aa-9e7e-0f913e8cfdda	0	10	f	\N	\N
87caf809-73ca-42c2-a3d6-5b0500deef6a	\N	docker-http-basic-authenticator	master	191eeb11-ca6e-4372-bc74-069ca0f6d426	0	10	f	\N	\N
6876d230-fdd3-4dee-abd1-1775087bbaf2	\N	no-cookie-redirect	master	9e76a86a-70c8-42ed-93bc-629b4892aad0	0	10	f	\N	\N
196f4eef-f572-4864-9400-a9a7c09650d8	\N	\N	master	9e76a86a-70c8-42ed-93bc-629b4892aad0	0	20	t	1e755447-e95b-4b2a-95c0-c15912990dc6	\N
b230106f-2703-4e00-ac94-c5e424dbd34a	\N	basic-auth	master	1e755447-e95b-4b2a-95c0-c15912990dc6	0	10	f	\N	\N
c5f18c2c-ae8b-4458-9481-86d4d393b5c5	\N	basic-auth-otp	master	1e755447-e95b-4b2a-95c0-c15912990dc6	3	20	f	\N	\N
2c371446-8e7f-49ce-a12f-a5291309e9f0	\N	auth-spnego	master	1e755447-e95b-4b2a-95c0-c15912990dc6	3	30	f	\N	\N
6d08a8d0-dfba-48c9-8d6c-f1ce717b5b99	\N	auth-cookie	redream	09707760-9053-4c27-b811-69f1fe5ea9ed	2	10	f	\N	\N
1577db86-16d7-4b47-81eb-ec011477781d	\N	auth-spnego	redream	09707760-9053-4c27-b811-69f1fe5ea9ed	3	20	f	\N	\N
abec8969-2be9-420b-b7a3-4633224f9542	\N	identity-provider-redirector	redream	09707760-9053-4c27-b811-69f1fe5ea9ed	2	25	f	\N	\N
8cc8392b-c315-4002-ac99-e6a4e59c444c	\N	\N	redream	09707760-9053-4c27-b811-69f1fe5ea9ed	2	30	t	1ba6850c-c3f1-4d9b-83e9-1e7f9e578652	\N
522fee9f-40ad-43ff-87a1-eef1d8c4004d	\N	auth-username-password-form	redream	1ba6850c-c3f1-4d9b-83e9-1e7f9e578652	0	10	f	\N	\N
54308b56-0e64-4db9-930e-106252c6d1d5	\N	\N	redream	1ba6850c-c3f1-4d9b-83e9-1e7f9e578652	1	20	t	27a4b9da-efc0-48eb-9cb8-b593bff9ea30	\N
8ec3178f-d442-43eb-9d71-a1528c473e2c	\N	conditional-user-configured	redream	27a4b9da-efc0-48eb-9cb8-b593bff9ea30	0	10	f	\N	\N
2202e6b7-c513-4598-8eed-c698593802e1	\N	auth-otp-form	redream	27a4b9da-efc0-48eb-9cb8-b593bff9ea30	0	20	f	\N	\N
6979ef11-d472-4f95-a0ac-c88c3f8b9286	\N	direct-grant-validate-username	redream	608558af-8ed4-4ebf-b228-b55ce3c11a04	0	10	f	\N	\N
5c52228f-0126-48b2-96ec-ae94ae81d085	\N	direct-grant-validate-password	redream	608558af-8ed4-4ebf-b228-b55ce3c11a04	0	20	f	\N	\N
766f1cd4-3f26-4090-97dd-5bb8b7df662a	\N	\N	redream	608558af-8ed4-4ebf-b228-b55ce3c11a04	1	30	t	f10f77bc-8e83-49ab-9fa8-49e44b085326	\N
cc894ee7-86a7-4bb9-a206-0517612781c3	\N	conditional-user-configured	redream	f10f77bc-8e83-49ab-9fa8-49e44b085326	0	10	f	\N	\N
72c8010b-4ae5-4ddc-8eb8-e1f8ac3969ac	\N	direct-grant-validate-otp	redream	f10f77bc-8e83-49ab-9fa8-49e44b085326	0	20	f	\N	\N
6f0a2214-542d-431f-b865-f7de3cfe0500	\N	registration-page-form	redream	3c9c4057-00a4-4077-8ce7-37793e25addd	0	10	t	c3ea7cd9-e8f6-42f2-b1fb-3cd96e0da7b1	\N
b45c2327-67fb-4f7c-8f31-bef11fbf1cae	\N	registration-user-creation	redream	c3ea7cd9-e8f6-42f2-b1fb-3cd96e0da7b1	0	20	f	\N	\N
f8bfcfc5-d6ac-4cea-89d6-f888b6a1aa93	\N	registration-profile-action	redream	c3ea7cd9-e8f6-42f2-b1fb-3cd96e0da7b1	0	40	f	\N	\N
d321a848-8c2e-4249-8188-c8a2a7d1bee7	\N	registration-password-action	redream	c3ea7cd9-e8f6-42f2-b1fb-3cd96e0da7b1	0	50	f	\N	\N
5b075703-bbbe-48d9-8747-6f8648744837	\N	registration-recaptcha-action	redream	c3ea7cd9-e8f6-42f2-b1fb-3cd96e0da7b1	3	60	f	\N	\N
662382d2-5ffb-4ed9-807f-7b8afaf70b27	\N	reset-credentials-choose-user	redream	c68b8049-9187-4f5b-96f9-744b3e641681	0	10	f	\N	\N
8138bead-6447-45d7-a7e7-f68de60525b2	\N	reset-credential-email	redream	c68b8049-9187-4f5b-96f9-744b3e641681	0	20	f	\N	\N
ef4b6616-d3bb-4792-bb1e-82f44018efa2	\N	reset-password	redream	c68b8049-9187-4f5b-96f9-744b3e641681	0	30	f	\N	\N
3e8a70b5-6737-46b1-8ea5-9f93524f1a7a	\N	\N	redream	c68b8049-9187-4f5b-96f9-744b3e641681	1	40	t	4aec7db6-2e7b-4de7-a072-a657ca13bca2	\N
708fb9dc-b809-4f01-80eb-fc54fe59556d	\N	conditional-user-configured	redream	4aec7db6-2e7b-4de7-a072-a657ca13bca2	0	10	f	\N	\N
6458f2c3-b93a-4221-a69a-2ef72e719f5f	\N	reset-otp	redream	4aec7db6-2e7b-4de7-a072-a657ca13bca2	0	20	f	\N	\N
71e7c17a-463f-4060-b211-6d5f496a3b3f	\N	client-secret	redream	93b5cb98-729a-4e31-8580-e4e3acb93e1c	2	10	f	\N	\N
8d5d846a-0807-4a94-8596-f1a2717ec84a	\N	client-jwt	redream	93b5cb98-729a-4e31-8580-e4e3acb93e1c	2	20	f	\N	\N
29d1c95b-5443-4bcd-953d-38cb7ae4cca8	\N	client-secret-jwt	redream	93b5cb98-729a-4e31-8580-e4e3acb93e1c	2	30	f	\N	\N
44433286-9f5b-4045-9508-14bb9949e2e0	\N	client-x509	redream	93b5cb98-729a-4e31-8580-e4e3acb93e1c	2	40	f	\N	\N
923585c1-fd61-4fc9-8503-c1a452591750	\N	idp-review-profile	redream	29a7f961-7785-4ab2-ad98-a3af7ee84c41	0	10	f	\N	327fea10-1b5d-4e95-b5f5-d0de664e340f
3c88c66f-a98e-41b2-9661-f86f547d6549	\N	\N	redream	29a7f961-7785-4ab2-ad98-a3af7ee84c41	0	20	t	8d5410b5-8224-4d98-adf3-dce5a6b5c537	\N
bd3600e0-8976-47bf-bc48-a68b1bbabc28	\N	idp-create-user-if-unique	redream	8d5410b5-8224-4d98-adf3-dce5a6b5c537	2	10	f	\N	68d47ddc-ddc0-4c9c-ac7c-afa3fff23b22
0793e139-2afe-42b5-ae96-c8f50b367729	\N	\N	redream	8d5410b5-8224-4d98-adf3-dce5a6b5c537	2	20	t	1ebabf19-ebbb-4021-b2f0-aac13aee2dad	\N
13541e4e-8959-48b9-800b-f9f207bbde5a	\N	idp-confirm-link	redream	1ebabf19-ebbb-4021-b2f0-aac13aee2dad	0	10	f	\N	\N
a03f6392-b8ff-4b7a-96cc-8a5f853ace28	\N	\N	redream	1ebabf19-ebbb-4021-b2f0-aac13aee2dad	0	20	t	a9cceace-21a5-46f2-b5f4-8c6283e374df	\N
fa771df6-b8eb-4acb-aba4-5f266be16610	\N	idp-email-verification	redream	a9cceace-21a5-46f2-b5f4-8c6283e374df	2	10	f	\N	\N
72912691-9a72-4fbc-ad2f-ed4447e0f0d7	\N	\N	redream	a9cceace-21a5-46f2-b5f4-8c6283e374df	2	20	t	1319d527-20a6-42c0-8b70-2f29f863d150	\N
c55c1305-bd6b-47d6-9db4-880b7e1d61db	\N	idp-username-password-form	redream	1319d527-20a6-42c0-8b70-2f29f863d150	0	10	f	\N	\N
f2d54de0-1eb3-47c4-8892-1db4eb6c59b6	\N	\N	redream	1319d527-20a6-42c0-8b70-2f29f863d150	1	20	t	5971c3b6-d49c-49f0-b3b2-b2ef1839e306	\N
0b478645-5891-4db0-beca-fb5360e423ab	\N	conditional-user-configured	redream	5971c3b6-d49c-49f0-b3b2-b2ef1839e306	0	10	f	\N	\N
85b1a259-9e73-4d14-859d-a85408e01673	\N	auth-otp-form	redream	5971c3b6-d49c-49f0-b3b2-b2ef1839e306	0	20	f	\N	\N
fa9647a3-c0d1-4376-8c49-a96bded9c63c	\N	http-basic-authenticator	redream	7acb976e-02ab-41de-8ab0-0bf1a73e35c0	0	10	f	\N	\N
71ddc820-92bb-4986-a798-5f06c74daa68	\N	docker-http-basic-authenticator	redream	b6115a36-7c5e-453f-84ed-996eb84edd92	0	10	f	\N	\N
14511dd1-1c1d-4c00-9dfc-672305a7af06	\N	no-cookie-redirect	redream	feb9dd9c-c1ce-4b56-b8d3-aa9013c5269c	0	10	f	\N	\N
7ba8c632-5331-4ac3-bcdb-e1e6cc0f5f77	\N	\N	redream	feb9dd9c-c1ce-4b56-b8d3-aa9013c5269c	0	20	t	17a6ba92-a813-453a-9e11-0445b9843ee9	\N
66e278e1-f0c3-499c-bf2c-6acf4295a3b8	\N	basic-auth	redream	17a6ba92-a813-453a-9e11-0445b9843ee9	0	10	f	\N	\N
4179fd04-c028-4708-8ef8-d264b5e48805	\N	basic-auth-otp	redream	17a6ba92-a813-453a-9e11-0445b9843ee9	3	20	f	\N	\N
0534585c-0c66-4a40-930a-e901404bd29a	\N	auth-spnego	redream	17a6ba92-a813-453a-9e11-0445b9843ee9	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
aeef319a-966f-47fa-91a5-4e611ee296fc	browser	browser based authentication	master	basic-flow	t	t
c0004148-6fc7-4284-85fa-5c7eb3ecdef3	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
b9eef15d-ea41-43b0-a45b-196561e6e2ee	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
574ebbc1-bc28-47a9-9632-56a6941c10e0	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
cdae0532-683c-4f07-b674-15c3c2c39bcb	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
a3622de3-5d50-47ed-8890-076742bc885f	registration	registration flow	master	basic-flow	t	t
28dc301f-d3f9-4134-8e42-b107b5d500a3	registration form	registration form	master	form-flow	f	t
34cd2989-bfca-4690-87f3-60d3207d5c15	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
18b98c16-66b7-451d-9989-586c31f697f0	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
29e706e1-63ab-4e25-8365-42d29710d151	clients	Base authentication for clients	master	client-flow	t	t
e5c18c07-8c6d-46dd-9830-f364a06e8fde	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
2916ba71-7c0b-4c68-b125-c875f93d3bff	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
d3ac06b8-ddca-467f-81c1-ffbdb3e2be53	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
3d326f4b-23e4-44e6-b51e-c617a46ec5fc	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
5441c2a1-d4ec-47e3-8a17-8d6f9d6ab900	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
0559698d-da7b-4e8a-9a0e-c94e88b1a7f1	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
04bb5e83-8400-49aa-9e7e-0f913e8cfdda	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
191eeb11-ca6e-4372-bc74-069ca0f6d426	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
9e76a86a-70c8-42ed-93bc-629b4892aad0	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
1e755447-e95b-4b2a-95c0-c15912990dc6	Authentication Options	Authentication options.	master	basic-flow	f	t
09707760-9053-4c27-b811-69f1fe5ea9ed	browser	browser based authentication	redream	basic-flow	t	t
1ba6850c-c3f1-4d9b-83e9-1e7f9e578652	forms	Username, password, otp and other auth forms.	redream	basic-flow	f	t
27a4b9da-efc0-48eb-9cb8-b593bff9ea30	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	redream	basic-flow	f	t
608558af-8ed4-4ebf-b228-b55ce3c11a04	direct grant	OpenID Connect Resource Owner Grant	redream	basic-flow	t	t
f10f77bc-8e83-49ab-9fa8-49e44b085326	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	redream	basic-flow	f	t
3c9c4057-00a4-4077-8ce7-37793e25addd	registration	registration flow	redream	basic-flow	t	t
c3ea7cd9-e8f6-42f2-b1fb-3cd96e0da7b1	registration form	registration form	redream	form-flow	f	t
c68b8049-9187-4f5b-96f9-744b3e641681	reset credentials	Reset credentials for a user if they forgot their password or something	redream	basic-flow	t	t
4aec7db6-2e7b-4de7-a072-a657ca13bca2	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	redream	basic-flow	f	t
93b5cb98-729a-4e31-8580-e4e3acb93e1c	clients	Base authentication for clients	redream	client-flow	t	t
29a7f961-7785-4ab2-ad98-a3af7ee84c41	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	redream	basic-flow	t	t
8d5410b5-8224-4d98-adf3-dce5a6b5c537	User creation or linking	Flow for the existing/non-existing user alternatives	redream	basic-flow	f	t
1ebabf19-ebbb-4021-b2f0-aac13aee2dad	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	redream	basic-flow	f	t
a9cceace-21a5-46f2-b5f4-8c6283e374df	Account verification options	Method with which to verity the existing account	redream	basic-flow	f	t
1319d527-20a6-42c0-8b70-2f29f863d150	Verify Existing Account by Re-authentication	Reauthentication of existing account	redream	basic-flow	f	t
5971c3b6-d49c-49f0-b3b2-b2ef1839e306	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	redream	basic-flow	f	t
7acb976e-02ab-41de-8ab0-0bf1a73e35c0	saml ecp	SAML ECP Profile Authentication Flow	redream	basic-flow	t	t
b6115a36-7c5e-453f-84ed-996eb84edd92	docker auth	Used by Docker clients to authenticate against the IDP	redream	basic-flow	t	t
feb9dd9c-c1ce-4b56-b8d3-aa9013c5269c	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	redream	basic-flow	t	t
17a6ba92-a813-453a-9e11-0445b9843ee9	Authentication Options	Authentication options.	redream	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
8d7dd784-b7f0-4984-a922-6f91e25ca6bb	review profile config	master
39de2fe8-0da1-43d4-9d7f-ac45db380040	create unique user config	master
327fea10-1b5d-4e95-b5f5-d0de664e340f	review profile config	redream
68d47ddc-ddc0-4c9c-ac7c-afa3fff23b22	create unique user config	redream
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
8d7dd784-b7f0-4984-a922-6f91e25ca6bb	missing	update.profile.on.first.login
39de2fe8-0da1-43d4-9d7f-ac45db380040	false	require.password.update.after.registration
327fea10-1b5d-4e95-b5f5-d0de664e340f	missing	update.profile.on.first.login
68d47ddc-ddc0-4c9c-ac7c-afa3fff23b22	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
0048bf46-9656-454b-a8f0-09fbea68c71d	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f55de89e-645b-4f63-8933-5fb1620f98df	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
24fa11d7-0545-439d-8137-c281a5e2691b	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
a0302968-af55-4e09-acbe-b24eb90afb32	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
62e4a9dc-894a-423c-97df-31e9138dc034	t	f	redream-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	redream Realm	f	client-secret	\N	\N	\N	t	f	f	f
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	f	realm-management	0	f	\N	\N	t	\N	f	redream	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	f	account	0	t	\N	/realms/redream/account/	f	\N	f	redream	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1590b1b3-f267-40ab-827d-e0d5e1d69f42	t	f	account-console	0	t	\N	/realms/redream/account/	f	\N	f	redream	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c9f7f839-967a-4f53-9fca-2f77c001cd6e	t	f	broker	0	f	\N	\N	t	\N	f	redream	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e2fd7fda-86b0-4101-bd79-07dd61d9881b	t	f	security-admin-console	0	t	\N	/admin/redream/console/	f	\N	f	redream	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
3535c471-4cc0-42b7-afe5-b726b6d1b066	t	f	admin-cli	0	t	\N	\N	f	\N	f	redream	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
b39939b2-0ddb-441a-a9c2-e24fdde29f44	t	t	redream-api	0	t	\N	\N	f	\N	f	redream	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
f55de89e-645b-4f63-8933-5fb1620f98df	S256	pkce.code.challenge.method
24fa11d7-0545-439d-8137-c281a5e2691b	S256	pkce.code.challenge.method
1590b1b3-f267-40ab-827d-e0d5e1d69f42	S256	pkce.code.challenge.method
e2fd7fda-86b0-4101-bd79-07dd61d9881b	S256	pkce.code.challenge.method
b39939b2-0ddb-441a-a9c2-e24fdde29f44	true	backchannel.logout.session.required
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	backchannel.logout.revoke.offline.tokens
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.artifact.binding
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.server.signature
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.server.signature.keyinfo.ext
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.assertion.signature
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.client.signature
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.encrypt
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.authnstatement
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.onetimeuse.condition
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml_force_name_id_format
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.multivalued.roles
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	saml.force.post.binding
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	oauth2.device.authorization.grant.enabled
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	oidc.ciba.grant.enabled
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	id.token.as.detached.signature
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	tls.client.certificate.bound.access.tokens
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	require.pushed.authorization.requests
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	client_credentials.use_refresh_token
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	display.on.consent.screen
b39939b2-0ddb-441a-a9c2-e24fdde29f44	false	use.refresh.tokens
b39939b2-0ddb-441a-a9c2-e24fdde29f44	true	exclude.session.state.from.auth.response
b39939b2-0ddb-441a-a9c2-e24fdde29f44	3600	access.token.lifespan
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
0757b8b5-0b09-4c77-8358-f20ce8468da4	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
b9b59c44-e482-4cc0-82a1-91aca2c8143b	role_list	master	SAML role list	saml
542791a0-80e8-4535-8cd0-e5680e9eed8c	profile	master	OpenID Connect built-in scope: profile	openid-connect
42a88c85-d923-43b9-8417-ce5c89f98ba8	email	master	OpenID Connect built-in scope: email	openid-connect
afc8438b-9184-4870-a083-b09d5f37a0e2	address	master	OpenID Connect built-in scope: address	openid-connect
69832938-6658-4dd1-af68-e982e260d52d	phone	master	OpenID Connect built-in scope: phone	openid-connect
9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
f139048f-649a-4300-b2bd-6e05734ffd95	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
4591f0ae-402b-4aff-88d9-541e221b8e76	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	offline_access	redream	OpenID Connect built-in scope: offline_access	openid-connect
022c9d07-6367-43bd-b6bb-5bc071a5e31a	role_list	redream	SAML role list	saml
546a8fee-dc9a-4826-b291-ed68c2674afa	profile	redream	OpenID Connect built-in scope: profile	openid-connect
976ff401-7b1f-4976-889d-93601ea1a211	email	redream	OpenID Connect built-in scope: email	openid-connect
5b2359a5-930b-4ee9-a76e-0b2742d35b98	address	redream	OpenID Connect built-in scope: address	openid-connect
cf12891b-51a2-4cba-9cc2-296605edee1c	phone	redream	OpenID Connect built-in scope: phone	openid-connect
e4b473b2-4160-4b39-b488-68d4de1e413c	roles	redream	OpenID Connect scope for add user roles to the access token	openid-connect
dec85a50-899d-4359-838d-615b03bdc17b	web-origins	redream	OpenID Connect scope for add allowed web origins to the access token	openid-connect
4eba81b0-c260-45eb-bbfd-738c89937b31	microprofile-jwt	redream	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
0757b8b5-0b09-4c77-8358-f20ce8468da4	true	display.on.consent.screen
0757b8b5-0b09-4c77-8358-f20ce8468da4	${offlineAccessScopeConsentText}	consent.screen.text
b9b59c44-e482-4cc0-82a1-91aca2c8143b	true	display.on.consent.screen
b9b59c44-e482-4cc0-82a1-91aca2c8143b	${samlRoleListScopeConsentText}	consent.screen.text
542791a0-80e8-4535-8cd0-e5680e9eed8c	true	display.on.consent.screen
542791a0-80e8-4535-8cd0-e5680e9eed8c	${profileScopeConsentText}	consent.screen.text
542791a0-80e8-4535-8cd0-e5680e9eed8c	true	include.in.token.scope
42a88c85-d923-43b9-8417-ce5c89f98ba8	true	display.on.consent.screen
42a88c85-d923-43b9-8417-ce5c89f98ba8	${emailScopeConsentText}	consent.screen.text
42a88c85-d923-43b9-8417-ce5c89f98ba8	true	include.in.token.scope
afc8438b-9184-4870-a083-b09d5f37a0e2	true	display.on.consent.screen
afc8438b-9184-4870-a083-b09d5f37a0e2	${addressScopeConsentText}	consent.screen.text
afc8438b-9184-4870-a083-b09d5f37a0e2	true	include.in.token.scope
69832938-6658-4dd1-af68-e982e260d52d	true	display.on.consent.screen
69832938-6658-4dd1-af68-e982e260d52d	${phoneScopeConsentText}	consent.screen.text
69832938-6658-4dd1-af68-e982e260d52d	true	include.in.token.scope
9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	true	display.on.consent.screen
9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	${rolesScopeConsentText}	consent.screen.text
9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	false	include.in.token.scope
f139048f-649a-4300-b2bd-6e05734ffd95	false	display.on.consent.screen
f139048f-649a-4300-b2bd-6e05734ffd95		consent.screen.text
f139048f-649a-4300-b2bd-6e05734ffd95	false	include.in.token.scope
4591f0ae-402b-4aff-88d9-541e221b8e76	false	display.on.consent.screen
4591f0ae-402b-4aff-88d9-541e221b8e76	true	include.in.token.scope
9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	true	display.on.consent.screen
9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	${offlineAccessScopeConsentText}	consent.screen.text
022c9d07-6367-43bd-b6bb-5bc071a5e31a	true	display.on.consent.screen
022c9d07-6367-43bd-b6bb-5bc071a5e31a	${samlRoleListScopeConsentText}	consent.screen.text
546a8fee-dc9a-4826-b291-ed68c2674afa	true	display.on.consent.screen
546a8fee-dc9a-4826-b291-ed68c2674afa	${profileScopeConsentText}	consent.screen.text
546a8fee-dc9a-4826-b291-ed68c2674afa	true	include.in.token.scope
976ff401-7b1f-4976-889d-93601ea1a211	true	display.on.consent.screen
976ff401-7b1f-4976-889d-93601ea1a211	${emailScopeConsentText}	consent.screen.text
976ff401-7b1f-4976-889d-93601ea1a211	true	include.in.token.scope
5b2359a5-930b-4ee9-a76e-0b2742d35b98	true	display.on.consent.screen
5b2359a5-930b-4ee9-a76e-0b2742d35b98	${addressScopeConsentText}	consent.screen.text
5b2359a5-930b-4ee9-a76e-0b2742d35b98	true	include.in.token.scope
cf12891b-51a2-4cba-9cc2-296605edee1c	true	display.on.consent.screen
cf12891b-51a2-4cba-9cc2-296605edee1c	${phoneScopeConsentText}	consent.screen.text
cf12891b-51a2-4cba-9cc2-296605edee1c	true	include.in.token.scope
e4b473b2-4160-4b39-b488-68d4de1e413c	true	display.on.consent.screen
e4b473b2-4160-4b39-b488-68d4de1e413c	${rolesScopeConsentText}	consent.screen.text
e4b473b2-4160-4b39-b488-68d4de1e413c	false	include.in.token.scope
dec85a50-899d-4359-838d-615b03bdc17b	false	display.on.consent.screen
dec85a50-899d-4359-838d-615b03bdc17b		consent.screen.text
dec85a50-899d-4359-838d-615b03bdc17b	false	include.in.token.scope
4eba81b0-c260-45eb-bbfd-738c89937b31	false	display.on.consent.screen
4eba81b0-c260-45eb-bbfd-738c89937b31	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
0048bf46-9656-454b-a8f0-09fbea68c71d	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	t
0048bf46-9656-454b-a8f0-09fbea68c71d	542791a0-80e8-4535-8cd0-e5680e9eed8c	t
0048bf46-9656-454b-a8f0-09fbea68c71d	f139048f-649a-4300-b2bd-6e05734ffd95	t
0048bf46-9656-454b-a8f0-09fbea68c71d	42a88c85-d923-43b9-8417-ce5c89f98ba8	t
0048bf46-9656-454b-a8f0-09fbea68c71d	4591f0ae-402b-4aff-88d9-541e221b8e76	f
0048bf46-9656-454b-a8f0-09fbea68c71d	0757b8b5-0b09-4c77-8358-f20ce8468da4	f
0048bf46-9656-454b-a8f0-09fbea68c71d	afc8438b-9184-4870-a083-b09d5f37a0e2	f
0048bf46-9656-454b-a8f0-09fbea68c71d	69832938-6658-4dd1-af68-e982e260d52d	f
f55de89e-645b-4f63-8933-5fb1620f98df	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	t
f55de89e-645b-4f63-8933-5fb1620f98df	542791a0-80e8-4535-8cd0-e5680e9eed8c	t
f55de89e-645b-4f63-8933-5fb1620f98df	f139048f-649a-4300-b2bd-6e05734ffd95	t
f55de89e-645b-4f63-8933-5fb1620f98df	42a88c85-d923-43b9-8417-ce5c89f98ba8	t
f55de89e-645b-4f63-8933-5fb1620f98df	4591f0ae-402b-4aff-88d9-541e221b8e76	f
f55de89e-645b-4f63-8933-5fb1620f98df	0757b8b5-0b09-4c77-8358-f20ce8468da4	f
f55de89e-645b-4f63-8933-5fb1620f98df	afc8438b-9184-4870-a083-b09d5f37a0e2	f
f55de89e-645b-4f63-8933-5fb1620f98df	69832938-6658-4dd1-af68-e982e260d52d	f
a0302968-af55-4e09-acbe-b24eb90afb32	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	t
a0302968-af55-4e09-acbe-b24eb90afb32	542791a0-80e8-4535-8cd0-e5680e9eed8c	t
a0302968-af55-4e09-acbe-b24eb90afb32	f139048f-649a-4300-b2bd-6e05734ffd95	t
a0302968-af55-4e09-acbe-b24eb90afb32	42a88c85-d923-43b9-8417-ce5c89f98ba8	t
a0302968-af55-4e09-acbe-b24eb90afb32	4591f0ae-402b-4aff-88d9-541e221b8e76	f
a0302968-af55-4e09-acbe-b24eb90afb32	0757b8b5-0b09-4c77-8358-f20ce8468da4	f
a0302968-af55-4e09-acbe-b24eb90afb32	afc8438b-9184-4870-a083-b09d5f37a0e2	f
a0302968-af55-4e09-acbe-b24eb90afb32	69832938-6658-4dd1-af68-e982e260d52d	f
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	t
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	542791a0-80e8-4535-8cd0-e5680e9eed8c	t
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	f139048f-649a-4300-b2bd-6e05734ffd95	t
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	42a88c85-d923-43b9-8417-ce5c89f98ba8	t
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	4591f0ae-402b-4aff-88d9-541e221b8e76	f
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	0757b8b5-0b09-4c77-8358-f20ce8468da4	f
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	afc8438b-9184-4870-a083-b09d5f37a0e2	f
10385b68-bb2b-4d4d-b01f-f54ac422fd8d	69832938-6658-4dd1-af68-e982e260d52d	f
d9564f2c-1863-4b16-84b1-3ec5a2eede05	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	t
d9564f2c-1863-4b16-84b1-3ec5a2eede05	542791a0-80e8-4535-8cd0-e5680e9eed8c	t
d9564f2c-1863-4b16-84b1-3ec5a2eede05	f139048f-649a-4300-b2bd-6e05734ffd95	t
d9564f2c-1863-4b16-84b1-3ec5a2eede05	42a88c85-d923-43b9-8417-ce5c89f98ba8	t
d9564f2c-1863-4b16-84b1-3ec5a2eede05	4591f0ae-402b-4aff-88d9-541e221b8e76	f
d9564f2c-1863-4b16-84b1-3ec5a2eede05	0757b8b5-0b09-4c77-8358-f20ce8468da4	f
d9564f2c-1863-4b16-84b1-3ec5a2eede05	afc8438b-9184-4870-a083-b09d5f37a0e2	f
d9564f2c-1863-4b16-84b1-3ec5a2eede05	69832938-6658-4dd1-af68-e982e260d52d	f
24fa11d7-0545-439d-8137-c281a5e2691b	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	t
24fa11d7-0545-439d-8137-c281a5e2691b	542791a0-80e8-4535-8cd0-e5680e9eed8c	t
24fa11d7-0545-439d-8137-c281a5e2691b	f139048f-649a-4300-b2bd-6e05734ffd95	t
24fa11d7-0545-439d-8137-c281a5e2691b	42a88c85-d923-43b9-8417-ce5c89f98ba8	t
24fa11d7-0545-439d-8137-c281a5e2691b	4591f0ae-402b-4aff-88d9-541e221b8e76	f
24fa11d7-0545-439d-8137-c281a5e2691b	0757b8b5-0b09-4c77-8358-f20ce8468da4	f
24fa11d7-0545-439d-8137-c281a5e2691b	afc8438b-9184-4870-a083-b09d5f37a0e2	f
24fa11d7-0545-439d-8137-c281a5e2691b	69832938-6658-4dd1-af68-e982e260d52d	f
c447134d-ed4a-45ed-86e4-8ef31e4e712b	976ff401-7b1f-4976-889d-93601ea1a211	t
c447134d-ed4a-45ed-86e4-8ef31e4e712b	e4b473b2-4160-4b39-b488-68d4de1e413c	t
c447134d-ed4a-45ed-86e4-8ef31e4e712b	dec85a50-899d-4359-838d-615b03bdc17b	t
c447134d-ed4a-45ed-86e4-8ef31e4e712b	546a8fee-dc9a-4826-b291-ed68c2674afa	t
c447134d-ed4a-45ed-86e4-8ef31e4e712b	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
c447134d-ed4a-45ed-86e4-8ef31e4e712b	cf12891b-51a2-4cba-9cc2-296605edee1c	f
c447134d-ed4a-45ed-86e4-8ef31e4e712b	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
c447134d-ed4a-45ed-86e4-8ef31e4e712b	4eba81b0-c260-45eb-bbfd-738c89937b31	f
1590b1b3-f267-40ab-827d-e0d5e1d69f42	976ff401-7b1f-4976-889d-93601ea1a211	t
1590b1b3-f267-40ab-827d-e0d5e1d69f42	e4b473b2-4160-4b39-b488-68d4de1e413c	t
1590b1b3-f267-40ab-827d-e0d5e1d69f42	dec85a50-899d-4359-838d-615b03bdc17b	t
1590b1b3-f267-40ab-827d-e0d5e1d69f42	546a8fee-dc9a-4826-b291-ed68c2674afa	t
1590b1b3-f267-40ab-827d-e0d5e1d69f42	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
1590b1b3-f267-40ab-827d-e0d5e1d69f42	cf12891b-51a2-4cba-9cc2-296605edee1c	f
1590b1b3-f267-40ab-827d-e0d5e1d69f42	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
1590b1b3-f267-40ab-827d-e0d5e1d69f42	4eba81b0-c260-45eb-bbfd-738c89937b31	f
3535c471-4cc0-42b7-afe5-b726b6d1b066	976ff401-7b1f-4976-889d-93601ea1a211	t
3535c471-4cc0-42b7-afe5-b726b6d1b066	e4b473b2-4160-4b39-b488-68d4de1e413c	t
3535c471-4cc0-42b7-afe5-b726b6d1b066	dec85a50-899d-4359-838d-615b03bdc17b	t
3535c471-4cc0-42b7-afe5-b726b6d1b066	546a8fee-dc9a-4826-b291-ed68c2674afa	t
3535c471-4cc0-42b7-afe5-b726b6d1b066	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
3535c471-4cc0-42b7-afe5-b726b6d1b066	cf12891b-51a2-4cba-9cc2-296605edee1c	f
3535c471-4cc0-42b7-afe5-b726b6d1b066	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
3535c471-4cc0-42b7-afe5-b726b6d1b066	4eba81b0-c260-45eb-bbfd-738c89937b31	f
c9f7f839-967a-4f53-9fca-2f77c001cd6e	976ff401-7b1f-4976-889d-93601ea1a211	t
c9f7f839-967a-4f53-9fca-2f77c001cd6e	e4b473b2-4160-4b39-b488-68d4de1e413c	t
c9f7f839-967a-4f53-9fca-2f77c001cd6e	dec85a50-899d-4359-838d-615b03bdc17b	t
c9f7f839-967a-4f53-9fca-2f77c001cd6e	546a8fee-dc9a-4826-b291-ed68c2674afa	t
c9f7f839-967a-4f53-9fca-2f77c001cd6e	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
c9f7f839-967a-4f53-9fca-2f77c001cd6e	cf12891b-51a2-4cba-9cc2-296605edee1c	f
c9f7f839-967a-4f53-9fca-2f77c001cd6e	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
c9f7f839-967a-4f53-9fca-2f77c001cd6e	4eba81b0-c260-45eb-bbfd-738c89937b31	f
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	976ff401-7b1f-4976-889d-93601ea1a211	t
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	e4b473b2-4160-4b39-b488-68d4de1e413c	t
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	dec85a50-899d-4359-838d-615b03bdc17b	t
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	546a8fee-dc9a-4826-b291-ed68c2674afa	t
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	cf12891b-51a2-4cba-9cc2-296605edee1c	f
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
979edf1d-6fda-4cf7-9eb6-3450aebe79fe	4eba81b0-c260-45eb-bbfd-738c89937b31	f
e2fd7fda-86b0-4101-bd79-07dd61d9881b	976ff401-7b1f-4976-889d-93601ea1a211	t
e2fd7fda-86b0-4101-bd79-07dd61d9881b	e4b473b2-4160-4b39-b488-68d4de1e413c	t
e2fd7fda-86b0-4101-bd79-07dd61d9881b	dec85a50-899d-4359-838d-615b03bdc17b	t
e2fd7fda-86b0-4101-bd79-07dd61d9881b	546a8fee-dc9a-4826-b291-ed68c2674afa	t
e2fd7fda-86b0-4101-bd79-07dd61d9881b	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
e2fd7fda-86b0-4101-bd79-07dd61d9881b	cf12891b-51a2-4cba-9cc2-296605edee1c	f
e2fd7fda-86b0-4101-bd79-07dd61d9881b	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
e2fd7fda-86b0-4101-bd79-07dd61d9881b	4eba81b0-c260-45eb-bbfd-738c89937b31	f
b39939b2-0ddb-441a-a9c2-e24fdde29f44	976ff401-7b1f-4976-889d-93601ea1a211	t
b39939b2-0ddb-441a-a9c2-e24fdde29f44	e4b473b2-4160-4b39-b488-68d4de1e413c	t
b39939b2-0ddb-441a-a9c2-e24fdde29f44	dec85a50-899d-4359-838d-615b03bdc17b	t
b39939b2-0ddb-441a-a9c2-e24fdde29f44	546a8fee-dc9a-4826-b291-ed68c2674afa	t
b39939b2-0ddb-441a-a9c2-e24fdde29f44	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
b39939b2-0ddb-441a-a9c2-e24fdde29f44	cf12891b-51a2-4cba-9cc2-296605edee1c	f
b39939b2-0ddb-441a-a9c2-e24fdde29f44	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
b39939b2-0ddb-441a-a9c2-e24fdde29f44	4eba81b0-c260-45eb-bbfd-738c89937b31	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
0757b8b5-0b09-4c77-8358-f20ce8468da4	d9c58c0d-4b4c-4d64-ad8f-87e67af2298f
9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	6a982c81-2821-489a-b5b4-6e2ea787fd7e
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
96a299e8-9aed-458b-a50d-20feb1defe5a	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
7772229f-b3b9-4fee-9f84-2dbc4fbfba04	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
7be05dfc-b450-434d-82d9-13945bb4a65b	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
357fbc5c-0d20-40ed-894a-bc0b3606cd9d	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
5f9bfa86-8936-44ea-bb92-2b773084006b	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
31576b6a-8733-465a-b731-31bec1931dd0	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
3900a33f-4035-48e7-a11a-ae428bc15408	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
e67c83e1-e390-4cdf-860b-f524c8e63333	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
cf4dfc69-0dbc-48cd-8c74-7b407b2da321	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
7674d970-cff2-47a2-b703-db529e647e70	rsa-enc-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
0e5de205-455a-4537-a8db-9342a259a776	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
61d39ad3-9125-4bad-b190-5d2a1bdd4876	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
d05addde-2dba-4247-bd0b-6b46c470fbb8	rsa-generated	redream	rsa-generated	org.keycloak.keys.KeyProvider	redream	\N
6c3362b6-ddc6-4b0e-871d-542e0a5b7003	rsa-enc-generated	redream	rsa-generated	org.keycloak.keys.KeyProvider	redream	\N
3e76a62d-c6a0-43e9-aede-07361694237d	hmac-generated	redream	hmac-generated	org.keycloak.keys.KeyProvider	redream	\N
250555dc-f1ba-469a-a935-cfbc5d07919a	aes-generated	redream	aes-generated	org.keycloak.keys.KeyProvider	redream	\N
6004f859-3803-4281-a129-57acfc2748e6	Trusted Hosts	redream	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	anonymous
5925538b-c354-42e2-9de9-f7f02de6fcd6	Consent Required	redream	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	anonymous
ab977d38-b98c-422f-9ee1-d95b7cff33b4	Full Scope Disabled	redream	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	anonymous
8783c2d2-598f-46b4-ba3d-cd4d79a3e327	Max Clients Limit	redream	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	anonymous
3b4ecb92-06ec-4802-932b-7d8ef641f488	Allowed Protocol Mapper Types	redream	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	anonymous
77bb911d-d9fb-4de2-aeca-91f6771e3deb	Allowed Client Scopes	redream	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	anonymous
9c1d3d68-eafd-43d8-b939-d95761734a5b	Allowed Protocol Mapper Types	redream	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	authenticated
d1c75344-f454-4634-a32a-bb7a0d003410	Allowed Client Scopes	redream	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	redream	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
ac1a39ab-5707-46b8-9150-36be3ffffd2c	31576b6a-8733-465a-b731-31bec1931dd0	allow-default-scopes	true
cc5d1c15-2273-4a9b-81fa-9df15473a1c7	96a299e8-9aed-458b-a50d-20feb1defe5a	host-sending-registration-request-must-match	true
d7e57e60-b89a-4837-90ad-fd4a641f8283	96a299e8-9aed-458b-a50d-20feb1defe5a	client-uris-must-match	true
f918cd65-f583-42ee-98cd-fa76e1135637	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	saml-user-property-mapper
5d99907b-6749-46cd-9c7d-c4238febd6bc	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	oidc-full-name-mapper
035ba9f9-2ed0-4001-bfd5-ddbf75e8f0f1	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c4444406-ec1a-427d-ab41-40a2a532c585	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b68c432a-1331-4752-a6cb-d641bec5c0e1	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	oidc-address-mapper
07571f31-ea52-4672-b19b-d8312539cfc0	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	saml-user-attribute-mapper
9eb52ee2-03c4-4097-8c95-85d0ff328ec4	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
48842cb5-635d-4c5c-ab91-1f3da0e5356d	5f9bfa86-8936-44ea-bb92-2b773084006b	allowed-protocol-mapper-types	saml-role-list-mapper
090dd780-b547-45de-9dd2-48c0b21688ca	357fbc5c-0d20-40ed-894a-bc0b3606cd9d	max-clients	200
14db23d8-9a7d-4073-8742-36fad29df1ae	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	saml-user-attribute-mapper
a7d91a90-9aaa-493e-9784-766795445d5b	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	oidc-full-name-mapper
2d58e7ee-e1a6-4f4d-93cf-d0fc2a2bb57b	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	oidc-address-mapper
71faf952-e090-4671-b50e-918c9e61aeb7	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f8123f06-88c4-4143-8d95-51387c9aff83	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
459d2c12-df5d-430b-8afb-c3f5f6e668c1	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	saml-user-property-mapper
6c02c2dd-33c4-401d-b9a0-acb5f7efcd93	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
fe589bbc-70ff-4ae7-a652-5d270bdbf510	3900a33f-4035-48e7-a11a-ae428bc15408	allowed-protocol-mapper-types	saml-role-list-mapper
eae15471-9c16-4932-b24e-baf3d285142e	e67c83e1-e390-4cdf-860b-f524c8e63333	allow-default-scopes	true
7e1031c0-ba9f-43f7-ac53-80d9efc8cc63	cf4dfc69-0dbc-48cd-8c74-7b407b2da321	keyUse	sig
708b5b44-d3c7-4560-b0e7-493a5cac3e48	cf4dfc69-0dbc-48cd-8c74-7b407b2da321	certificate	MIICmzCCAYMCBgF8wjIAbDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDI3MTQzODQ5WhcNMzExMDI3MTQ0MDI5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoh0C6aTJmRafUWZqhrfnPDRwtBY6OJV87gw/c4AlN6aNWoQVYCOlNlW4XXNwcsJDNNBlU3NcZR5bTRBzBSlyEVlGY2G0HwNjwqjwIHV6LQ3Xy8UpJAHuu7WjESk/0g/WXSiOnEJPPrvgmUahm8uj7LPpH8GsPcHOb6iW7IuryO/XGhPORruERCQqcFq53Iicws6nXJJXuTONMjBxlpJRFsPOUFHn6uQkh/zxWetf1RN//PpF57Dv8JSteJ4vQhLlfzNOwhIshC91G1Z20Ao4LsMATKLDc8p/Q2oVYjGTaadi9t1+QNOaRdf7AI36X/Sd99ph0o8gCpR0Lu/AivP4BAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACm3jb0V0XUiLORFK41e4wcgLAPvPmCJcPljjqPT91r4naKlrOlzHgS3BSqz1jAUdk/IJqK5Tf/JZPPowV/8bifQoM4yXJpcoSgwZteZgcsODT3WSQSEs+IZJOhcjZvlAo/dJxqJa8nWm6mjNXtON3eJtw7y1knaJ39d+YqTexXX350EL0e8N/eijW9hGpkvSSyYh6PlE60faEamm6TniwLhhoU7Kl3F/hoB350ehpVrrY4XprcY6wveu4Zk7leiajxK7uYiornO0In9LdnS2KpvD9bIqkdlTV8JVUqKxBAmqwiKq0y2uCM6Zf73L0Nr8pI34vGDxUXJOyGeFDfaSKg=
171f8028-f758-4564-9077-f8663046c7af	cf4dfc69-0dbc-48cd-8c74-7b407b2da321	privateKey	MIIEpAIBAAKCAQEAqIdAumkyZkWn1Fmaoa35zw0cLQWOjiVfO4MP3OAJTemjVqEFWAjpTZVuF1zcHLCQzTQZVNzXGUeW00QcwUpchFZRmNhtB8DY8Ko8CB1ei0N18vFKSQB7ru1oxEpP9IP1l0ojpxCTz674JlGoZvLo+yz6R/BrD3Bzm+oluyLq8jv1xoTzka7hEQkKnBaudyInMLOp1ySV7kzjTIwcZaSURbDzlBR5+rkJIf88VnrX9UTf/z6Reew7/CUrXieL0IS5X8zTsISLIQvdRtWdtAKOC7DAEyiw3PKf0NqFWIxk2mnYvbdfkDTmkXX+wCN+l/0nffaYdKPIAqUdC7vwIrz+AQIDAQABAoIBAEwbKGQGdbgx5KTFAkvZYWLbrMm4JLSUs/kQKu24Tvtcc2L/vIYRICrlPJ5YVR6vrfS9fmMQiCLmbXpi3Al+J2GsCZVYx4Qk1tN4TTvs53FEudNInB9zlGde110togXuQc5csNUVa2ryvSWw4rf7IrOrkCtEq1SBl/PlPbzQ/AD/z0NuME6+citGKPb/5/FftqHiESg2IbDr4Io/uj10MZ0XfAsY8OpDpJq98Vgt4WK6IUNs5+d72ct5obw9Y2cJMVWiHpp1OEzDiGKnvZQTsuk4gtqdi83NPWGhjv5aYwqb4Md76iMRZ/6C/mZ1/4G4vzRVtcaSXMoudiAIf9dXrzECgYEA1dj52stX1HMWJ7QvPRaWIkaK+5YpHDkN1d2hqfMpmxt3miPWH1n0y9SV9AsS7zDLexKNRQnNGdNbTPM0WTk1VKxYu6CcdWv0cVPanF/jebrC58zf2e1GsloT+wRREZm4gA448NHqB0JxnlE3/3JsYKhZ238liraXNXcijDbRUqMCgYEAyb9o8xaNSwTp0bwPLAd08QGcdUiiifF4VhLGkDoY25slg6CR+vfHZdUEs5pnGZTwYZbv00SZDNodYYhmzAAkCYrE/CuNjJugvHoxfzym7MLelf1qPdcP/ulpf1ygnqumAM8TtuRAd03Qm7lODY9MeEAIHbIyQ9TmobzQwA+P2wsCgYA4Q5VBfrzGFd2fZqYDIZ0wuXS5ywFX/p7oRR7S0zqAJ9LpCEK/DvD8bBtkEUHTEviGkhP/NRv0jop4DYkZbJbeh1X1T8W6k0PGSXS8LfJwxbWgPWQsN2ShalfVdIZL5jEH6DYNDn3PmSjBqcbc++MN711tBd//xhi0pXq+f3HFlwKBgQCzu/Ux6/uAxCXTFmml3hbOx5Kt4kH8BsYgWKXRxBB1RSkMtTaYkbpw/HAt2fbUEZ5+MswCOfDoREE8rRp30ABLB/gqeFqo09VFVM9X/Z7w+0L1+Uh3Q2wau7OjJdBqy50ex11W6M6N+yNIOLRS3EFSOCmC20hwqfG2UdLf6H1OtQKBgQC8Tz45Z/rRkBvAtYO89eEszfnLStO3+GxCQkgzxnurADfTzN4B+VP7N8eHPgSFL2UmJEnJnZIwDPlHFm5uozlv/9JtgtBqWFBWvFEjTeXhcbMemyjom62Psb8YTut+qadAXE61Q+WKJaGhO85tcPfsVmEwC2IxzCyJDiGKePuyPQ==
b1aeeeb2-ec82-4373-8244-82fff4904fcf	cf4dfc69-0dbc-48cd-8c74-7b407b2da321	priority	100
07f296ba-ed5f-4441-9d74-371553bb3bde	0e5de205-455a-4537-a8db-9342a259a776	priority	100
37ac18c1-b152-4825-b3f0-a2e95cf6ff57	0e5de205-455a-4537-a8db-9342a259a776	secret	XH6waH-fyO-_fTGe8PNghdv2Mr3eqTKeFdTcxYafJfHb89JkB-gYIWoVO2fH-94_RA6ChKIQiHd9L0yy2B9RNA
33aecbc4-9a2a-4e3a-a0f3-a984baa6d8ca	0e5de205-455a-4537-a8db-9342a259a776	kid	501f2ede-7478-4261-a29e-f9d205d26301
94f34d6c-86d7-4b11-bef4-ba7e8fa117d4	0e5de205-455a-4537-a8db-9342a259a776	algorithm	HS256
f4aa0c51-856e-49b6-8799-f36cf5e44f26	61d39ad3-9125-4bad-b190-5d2a1bdd4876	secret	MWcV2gq1CtMFipImlR1f1g
4db5b3a7-c68a-4d3a-96ad-2f89cf328c6d	61d39ad3-9125-4bad-b190-5d2a1bdd4876	kid	54379c88-8675-41b0-9b16-2529e9efe2d5
a8f02548-05ac-412e-8b1b-55f731e82f2c	61d39ad3-9125-4bad-b190-5d2a1bdd4876	priority	100
f6406882-1ef2-4fa2-960a-2a37243f64e2	7674d970-cff2-47a2-b703-db529e647e70	privateKey	MIIEowIBAAKCAQEA5tdJqWvcTo7EOJqQiplLoLZgxe//WCONr+z0/cqaDacdTqIbUonBUQU9wUdBrYFjNS0ZOjk8a1bLWs7RSXfGsP3elWCxAP9S1ekS6pzcv65PNBncsAg9kzHN90j3vQX+vRUcUV/bZGMBNygA2rPYNhJjF5Q+diYY/lY+bFlLZQq+wKtgbo0raAlqvyl5OQaxpCGW3SDwYm5BCLyf7CVfGCDJMyqHnHrwIbSKRLCOD2tNdxRcS6zwLAphaOrxlTk1MAfVFfNu1rznYMgzvWigZMNRaqX6SM7fd5Mi/xlCxnbjlhaiMGzrfCuUU+j1L5CidMMkChMlbHAWMQm+55DxeQIDAQABAoIBAHnfH5y6vU0cQqw/rh/+XtcyclUOKBk4bA19ZLq4xCyBFg/1tccVw2IrCjeIjzwzG1VvwenjXeqtoB8JIaVP/y5iWakzqz+DjRAyRTJoLoNkW5x+Ku0k7J1RphPwChtZluvswU6U9RdCzdl43TqZyISDoJ1KPs/RvVBJ6Br76boluTwNHV+M0Z8a828u7WskVN1qbCe9+86coK2IXF/rxPHFgm4Am9BIv14oEYgMqEKv5jyTpu0XsTrE6kvL2PsS8v5CgY7/z0lPfGqnG9PsQh4O3/ULCTWUMQCwCBav4f53XPNDnCv0Bsspic65VXQTVFMw7Wo25JnZZ3XfCI9gCiECgYEA/PTLYlFCLQC/aUCyHZ42Ks7HrNnJty/0DMS0i21qnqztCn8mJX5NdonR3Bt/7NEhVeLtjsDLX28m3KO8WbNk5wiiEwe3YRgSOCbmmbPzf6G2dIgZ8WbDsz3Lvnyrfr3tG/ormV+5HHVUf55oRnriCegA+JerVAfqYTuCS/xaZ18CgYEA6Z5el1Mj61Ck9pZNedX+C1k7xj7uEwtZW8oIIAj/fstecxcyxn+wtBT1rs+l00OsknKiuPBI++oBfal+lXabFQaf01QCpr6d213X2LKQm2NU2n0DQf9cv4Pv7rq4KdqJdV+oY8tu1MYzjyw3UG8giP5dqMonTwyUYGGBEWJcDicCgYAaeVhL6us9IIXn8yBxHxzWMBwPyB9nb7pgF7o5mXL+NmT8o0APzn8298eh/LLPyzds8LoiJaVjUJPFpdFRpgfacjncOgOEQuutOs0Jqx7B7d/VpGTqsfGrcb1AK3YbZq9JLU6g17bc9p6oWKDbN4MuvDxVyDHjMoziLkM9xqSDiwKBgQC/byXl7JwHbLrw0XNFPiSBmiqQJesise8UdzY3QghTF0UbHExgOixLNM2p5L/moZLdIpDS6Rt1SmjUVzrCMUGddiMrobDWgGaMZpbEHHbAziGvNDeiMiYHTY8j2d+ldE2lX7B1rjLwqkV/seTVxWost/t5n8WcUhuX6u4/l5EFiwKBgAG6MCD1vMv2vWnfW8Fj8ucpDiEvXaeP4i7dHVNVaUdjM+GneX44ExPvsVj1wPLrffroQVWzqhCIqV+u5wcFoc+IVe2gKmvv0DeTHdd+wWwXDWFhHB/2aN03nMYCPLq5uRcXItNYgjUQPUZUmMVpwtVdfoJxl3+JF6HWfXp0n2hK
2b35853e-7493-4473-a568-7eb78be44e35	7674d970-cff2-47a2-b703-db529e647e70	certificate	MIICmzCCAYMCBgF8wjIBHjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDI3MTQzODQ5WhcNMzExMDI3MTQ0MDI5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDm10mpa9xOjsQ4mpCKmUugtmDF7/9YI42v7PT9ypoNpx1OohtSicFRBT3BR0GtgWM1LRk6OTxrVstaztFJd8aw/d6VYLEA/1LV6RLqnNy/rk80GdywCD2TMc33SPe9Bf69FRxRX9tkYwE3KADas9g2EmMXlD52Jhj+Vj5sWUtlCr7Aq2BujStoCWq/KXk5BrGkIZbdIPBibkEIvJ/sJV8YIMkzKoecevAhtIpEsI4Pa013FFxLrPAsCmFo6vGVOTUwB9UV827WvOdgyDO9aKBkw1FqpfpIzt93kyL/GULGduOWFqIwbOt8K5RT6PUvkKJ0wyQKEyVscBYxCb7nkPF5AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGConaAcCQ9Tg5r0E8w+XlsluqXcLXo88DQ7avoKUwOBZDNB5O1Q/WTX+lmOhGs4qooTBqRpPB8gMrmAcGRJZpu8D03mos9WWHYJg3jtIxbS6UoEyHZycKEv6PdC1i8j+Z5kc+9mojSgEi8keigVHueE6ucqzj1YUd+wDY2V9lzbuVbpI2/Uknv3EM6U2x1C47F3w/RQ2rzsBOKChsQDgpdaQXkbMsExpIg5LagDNerPxu4McnBGrrDLHeBlZ1AD23z5s0Qb8kHs+bJNA/c+SvsPs5GWFTmAbMEZsJcK/WrQwNg5gTC0Rp42DsU1XrKlaycYa5uvyTw+lbWz81D+DBs=
977669c0-faba-4040-907d-0618e558deb1	7674d970-cff2-47a2-b703-db529e647e70	priority	100
afba1dde-ee88-4ca6-8e33-92de08a6ee4e	7674d970-cff2-47a2-b703-db529e647e70	keyUse	enc
dec893b6-4279-4610-9790-dc9f06bcd965	250555dc-f1ba-469a-a935-cfbc5d07919a	kid	b9a7215b-3356-4174-9464-cc341b349ef7
0f2fd117-b771-4c55-9450-04f6aeb24a3b	250555dc-f1ba-469a-a935-cfbc5d07919a	priority	100
504a3fff-6f97-4c7e-99e5-fa442062849b	250555dc-f1ba-469a-a935-cfbc5d07919a	secret	rBJcUC_jL_MJTtvx_7V9mw
ee6f79ab-a15a-4196-bd37-fd3a3d8a6bc4	3e76a62d-c6a0-43e9-aede-07361694237d	algorithm	HS256
192b318a-d104-4d0b-879b-d734f3b0a4fb	3e76a62d-c6a0-43e9-aede-07361694237d	kid	6c838915-93a9-4e21-b974-b8ee0c4eb105
c464fc10-c290-4b4d-8036-7c2e9b420edd	3e76a62d-c6a0-43e9-aede-07361694237d	priority	100
8bbcaa85-a4fc-4415-832f-b7dbdd75bff3	3e76a62d-c6a0-43e9-aede-07361694237d	secret	pGWjoh45viLn5yFh0X7lun4vgWpI4xzpsIMi6e3GupEWYSHIF3WRIa0xPPDql2-ggE9ugimgaL3iETJ9TrhOwQ
09486b25-a97a-419b-b1ae-9f3e449206cc	6c3362b6-ddc6-4b0e-871d-542e0a5b7003	keyUse	enc
4001f33d-6060-4615-8b18-b524aafa8ec7	6c3362b6-ddc6-4b0e-871d-542e0a5b7003	certificate	MIICnTCCAYUCBgF84O5UujANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdyZWRyZWFtMB4XDTIxMTEwMjEzNTMwOFoXDTMxMTEwMjEzNTQ0OFowEjEQMA4GA1UEAwwHcmVkcmVhbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJSe0zLjMs4j2mSWyqcCnLw2pmGrwbuRflaW+HAyQkwL/VEIZ6txM2H8LdiwbMeDrkbFebrQfzk+AgzxMim3CWHrSElyi3I+1gUI/ALqCBm2FQJHja+iRZk3AX9BV+qOwJb1qadZB19KAdTQCAkQ/KFz3ZXVFzYp44TSXq5yn875M7KtIBAccR9XIwB8cuvWAw15l/yuqnh4b7/w/FAd/Zf2g1c5aHNNx7ClfxxT79MFQA/txmE6XbAGt7xHUW4GXD5wtznMc4Wo5YBOo/XOp57RjCqc4kIWRLoPfNK1cNU7IMb/4qQ1JAxTO8EpYyN/s1AQzR18QqDMTTEqF+8FYTsCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAcjdGKQlb1RiN3srOs/UISIXvsh2r+lGcOAdYYlzUvJ5eG70KFguPQcTY5/zUcTbcMl07LnvHsJQoF1t1URCEmzEisO/xIk4SLJtbc1irIQEbtDgg+I2nAL4UwfCzjsb7q0M934kiEgDBULbiGjreyvnZZZTgRBl7Acr88cNJEQ8zQk6IuL/VM/KG9M+MfB+5eLg6EhuQpI4nI7mkL6d/iApvYAtuiYNLTu2To/0DCN3+jvB3B2tj6dkOzwl5n78Vg13DBDf5w0SyI8mVDTEpwS1VDVMrbwepcaLorL2lwCC84A7mTdOup5/OLGQmXZVGFmz46Ehtx05wedesjw/p1A==
07c2ff52-5424-489d-a3bd-6cf4cb999d0c	6c3362b6-ddc6-4b0e-871d-542e0a5b7003	privateKey	MIIEpAIBAAKCAQEAlJ7TMuMyziPaZJbKpwKcvDamYavBu5F+Vpb4cDJCTAv9UQhnq3EzYfwt2LBsx4OuRsV5utB/OT4CDPEyKbcJYetISXKLcj7WBQj8AuoIGbYVAkeNr6JFmTcBf0FX6o7AlvWpp1kHX0oB1NAICRD8oXPdldUXNinjhNJernKfzvkzsq0gEBxxH1cjAHxy69YDDXmX/K6qeHhvv/D8UB39l/aDVzloc03HsKV/HFPv0wVAD+3GYTpdsAa3vEdRbgZcPnC3OcxzhajlgE6j9c6nntGMKpziQhZEug980rVw1Tsgxv/ipDUkDFM7wSljI3+zUBDNHXxCoMxNMSoX7wVhOwIDAQABAoIBAQCEQs/rYnvtLcUGbZeNh2qaqPvqweKYHQPU5WfU2TVc3fKisZso3IYAtl7Kjz9PUuW+f7E0SqZd98v1XpTowMZtyOg8zN5CXp8yPeugYEuzLfKGY804t22+y0/ewvUNfdrwvVEs57MC3ybAEB6GiwJ4YFebJtcQUbjzlA/EqaeEla/Jlq0vLrUdX++QnlVnsDcqy5jsrEs6mSqX0YK7s9zzXDG6gl/yoeFTiA56VBUIh/iGUhlIfqPeVTTgpHVbu5JbRMnMJ6tSVvCarsTta7Eq0JSGHMmbiTkoCMR97hT0DpOr9/XZmSFqa0Am9eOVpkv2mlzcAseygisAFchXxixxAoGBAM/BJjbq5KfeQ7eDrA7yHdXWoYpmT9xPvTGOa8rQq0map6+c9Ws5lZMr+MLlx1EqjB6zT+0Sivd1YIeN9ctK3/UNcxkSME39ZPWdlAxyPJ9ZqLFdJ5hw/erqXfwaLK0N4swgLx7jVoPAbdpCt4Lxah0gXvmOlxRb+pQn8e/0My2DAoGBALciMs2SdePGN78TbRuU80+A98oPedS53i5rDi/YtQ3TR334ROHw9UP8CXpL6ghEfPiDYo4Mo5KlIUucUqXL/bNErSFISn5s40roxFjBE17kSItX8fSzlPYeiQI+OhYQsXCmHWPsNKzF4cLyAMcEFr9FY8cAxQsPgtyMk3LH1ifpAoGAGdbFAPmP/MzpES8APE+ipFDwgH0fG6CTQFGdWHlBhIMGrhHQeEiOMOK8KslXU+H90Wet3id7PzHLErD2TBWA60KD+S9I8Lo+T0oM+stOfOcy0vRqE0yiWBBUJiG/QrrCZW7vTWErBnHtd8Lqfg+2ie7XwSQZ6D9UWA7ryVNO9i8CgYAOif2EipMncS4t0koAPZQPhMqnVRE0DUmRX9hxff/pyBNN8e7uDSY7rn/GIM7Et0NAq5Wgd2ppEwkQqql5FjffCp3AHbAkV1q4MMCd1z5Fc1Q7E9FWvwcdfxEbh3svE0YzDk0ZCMCp0s/4nSPoqO9xYf3o56u9FA8smVB/dVQQOQKBgQCRfI2P5xg9t9u+E1Osz6Dr9fjcPivoFMiJT2rnN5nw8OedtZYYa4Qhub7ADyIqFYflw2FWIX+fnvp4twop1TYZxZeXn6v9fRLdWgjKB18/vsFV111Cqan+88oURYgyDfE+jXgBhtXDB8x8ZR88iHhLrbh9FNguVd2cYwCdf9Zwow==
5f41b22a-1cdd-4f03-9cff-7ef7a89ff269	6c3362b6-ddc6-4b0e-871d-542e0a5b7003	priority	100
f2bda757-c2da-4504-9707-842e1ca76a6d	d05addde-2dba-4247-bd0b-6b46c470fbb8	keyUse	sig
7b317597-1e37-4742-9eb2-61adeb8673fb	d05addde-2dba-4247-bd0b-6b46c470fbb8	priority	100
b7b2a11e-6d5f-470b-8539-f550c95b6fde	d05addde-2dba-4247-bd0b-6b46c470fbb8	privateKey	MIIEowIBAAKCAQEApQwQo+J6dloUlAiehRFh4RLikCCTu1wQkbELktsXmwfXjhFnck5c4R9lQCw7qiglHbC/cJCbwRMRJog0p6xeEXiqYBQimZBZFz5PCIp4lCwgceZilJENN2VLhMZgNjLK2sg9iKqbeCQbjjbyoU65IJiYrMtUExEaTKAsUWW1w19F78hH4DRZdomar/1UOGbGKyPLnx3VoORhsofVZXN2Nw7CuIBq39peNbMuAzexOj1NcXJq3rS4pR58b8B8N1on91egyJfFe41Z0DHVuzefcw7EZmFhA0NxKwQLjwqbQ5aFLHWoWoCg/KBnMBsiw0udBBycR4aDw9KGcodzpPKxNwIDAQABAoIBAD7+qeNDcCZ4H16ZI5f6mHdFs//6zyg17YUOJDK7OPlNNvLcpbU1P7IVP5oMyAEcLX51lbwrFafN1T/1wNM2sPjOK4lcZhBizf5XI+dIotk7Nm8C1iGKc5bvLLHS3aoSHOcAgqwFIi3q6jGPu2/iEjrkw3FAciiM4JLal8/BmGym9ZpwsZNZSWUO0ub11sc7diXpOTkaQ6mppTU1zp3rEQejNnDkQCidYMAp9Sk64fx1rqZZ5T7JrPycpV0dOmwC4rOpnwjqSJnZLjokn+YCmWkZ/XaBrm38+Th9guezNIazSLDAL6+W1Uq7cvKGs+M6jCvBIuxsDsx/hi9nX9HxY0ECgYEA04y+CedJSsIJGxidFJQSqS8ZZ2fOKp5Q34NdulOrV/bqiPJA5fd2nKCHXGkMD6FfkHKwRjcwMKEt0htVPcJHLZX/tLvBSoH25cvCUiQsVlsUHU28JS3WlnsX3PJvoKq46iOOpHWWJruCFxH9q7uKMVJ7sVP8Dm8vo4lgOfxIUocCgYEAx7nyRfRixTL0T07o5jQzEBiEzVwOtqhL69BITHFADdkZtDyR1TerR52JGc2WQocKnUn+wTDU6d9d2EN8QhFMDrhpze948bDtN/L3m+EyTfKhUn6mH/A+vymZvbHkO8UZoCbMR2Ga3cwc165XCenJAAv2nNPTNiN3sNXQoXt1Z9ECgYEAyk09LptPK36C1rajAJrZfZDc6lYKghcDn7swVo7MvEIT5wJDracIdp/M0kJilk/r42bJy1vbaaW4+8PHsFepWZ6n+V3Tajz+rqI8IfEVtT9D7QH5elRrcVwlZdUxiqO4Ua/PKNaJ0GBf90/tFd0yOhh20Q1PbT5GgE1PCCSJxOECgYAej4lOwvJKEl3ntL9WWi5mDBpmAewObvoO/zPQ3pNaixmvxoTaB0aiEqzj0d1oGJm7L5NXpE0v7AnECa99vH/S0Mz/weDTuqrRoM/afj7gRnwAz3hD8tLnFUp9CDdQHfyp0MX5NiooPg87wWV4Etm6tBnsLU1oP00VNeJSkz2HwQKBgDbDkTw34yoVO4xNf39i+Dw735Ul61XSEgfnQTlRXbUqKcRQr6XpO7rbNJEIBobW0klibjFxf++1sk5CzjZRPiPRRhBMlxeuZpjUyC/M+paG/JDv25UjhcNy50feyvwLcFAp+7BwUatm1J9vSNVWzgMl5HGfUiTc09cmUaffu2UV
57885ca2-5b26-46dd-8db4-0762fe67188e	d05addde-2dba-4247-bd0b-6b46c470fbb8	certificate	MIICnTCCAYUCBgF84O5UIzANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdyZWRyZWFtMB4XDTIxMTEwMjEzNTMwN1oXDTMxMTEwMjEzNTQ0N1owEjEQMA4GA1UEAwwHcmVkcmVhbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKUMEKPienZaFJQInoURYeES4pAgk7tcEJGxC5LbF5sH144RZ3JOXOEfZUAsO6ooJR2wv3CQm8ETESaINKesXhF4qmAUIpmQWRc+TwiKeJQsIHHmYpSRDTdlS4TGYDYyytrIPYiqm3gkG4428qFOuSCYmKzLVBMRGkygLFFltcNfRe/IR+A0WXaJmq/9VDhmxisjy58d1aDkYbKH1WVzdjcOwriAat/aXjWzLgM3sTo9TXFyat60uKUefG/AfDdaJ/dXoMiXxXuNWdAx1bs3n3MOxGZhYQNDcSsEC48Km0OWhSx1qFqAoPygZzAbIsNLnQQcnEeGg8PShnKHc6TysTcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAm5/ArGejzw1XJEhc//mV4jypaSilXg4iPcF3CyLAPBJlwyPlEB3yM4xewGeXY0y8OcgFzzIWILN5PCWeZvUzElYXwPwRsjcHJ1jtXP74+Sbh5f1RJG2eKuDB6OR6wx+a9Kw9ly3aBE8qX41wbWiRZkPVeSk8RTNvU6h7d/THypwMS53ytFb2iC+Zhp5ENjJIUh5k1FH9lQgluKkp2iwIVWIxWHzXSkw6HYooVj4gpVcuALLuvhVjrIa9cvf/2RLBJF4BUh5fNJGoo2BNmvgcZ/jsm+sTiHjFa2Xn03dT9heJ/r72n2UOGzIt84B6/+bEAWF2RHPP3uEgrpJNIVVL2Q==
a0e9d21e-75be-49f9-badc-82f7a81a911e	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2d435535-aa23-4ad4-9809-66484284f921	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	saml-user-attribute-mapper
6df90674-5444-47c7-8286-27cee1a231a6	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	oidc-full-name-mapper
4435d683-31e2-4e79-88fc-6a361a8f7c6a	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d299a030-2b16-4661-9fed-a98b8d901773	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	saml-user-property-mapper
a2357067-67d9-4d58-8d4d-1567be15fb34	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
70e94a20-7e47-4354-937f-9623b0faac23	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	saml-role-list-mapper
58fdb63e-32be-4e28-b31e-f8fa1f3b931e	3b4ecb92-06ec-4802-932b-7d8ef641f488	allowed-protocol-mapper-types	oidc-address-mapper
5770ae5a-5445-4dda-b86e-0c343e70e40d	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	saml-user-attribute-mapper
7010d801-bba2-4d53-bb53-1affa2088c77	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	saml-user-property-mapper
7a01d5b3-56ea-4942-8239-2d24e4a9716f	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5fc06844-2be5-4467-b9ed-a5e58b37444f	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5f797550-24e5-4a1b-8b2c-bd5ce6531eaa	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	oidc-address-mapper
a295db6d-d9e2-442a-860c-700279d1903c	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3b89d53e-07c9-41b4-86f8-17c667683c07	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	saml-role-list-mapper
c5cf1959-9a39-493b-b261-754e9fed5dfa	9c1d3d68-eafd-43d8-b939-d95761734a5b	allowed-protocol-mapper-types	oidc-full-name-mapper
ddd48abf-b8f0-444f-b5e7-5968a2572df8	77bb911d-d9fb-4de2-aeca-91f6771e3deb	allow-default-scopes	true
e9ab53a2-d085-4f72-955f-ef3ec9081f70	8783c2d2-598f-46b4-ba3d-cd4d79a3e327	max-clients	200
c6e0ec07-2f2d-4074-bd98-abce2043a902	d1c75344-f454-4634-a32a-bb7a0d003410	allow-default-scopes	true
e02c3797-95f3-4797-9fc7-8736205be978	6004f859-3803-4281-a129-57acfc2748e6	host-sending-registration-request-must-match	true
598b36a6-3c4b-4bca-ac1b-a06ec55d0a19	6004f859-3803-4281-a129-57acfc2748e6	client-uris-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.composite_role (composite, child_role) FROM stdin;
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	f91929ba-dfe3-4598-97af-2ae49a27cff4
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	7ebe6665-a39b-4feb-9154-6cfeb10b05ef
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	fd30e128-b3b2-4e07-9034-de21a5be429d
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	8deeeeb9-f4eb-44b4-9a17-c55acc586331
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	600aa0fd-5ebe-4c8e-a057-619b3ccd7b56
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	dc2cbc18-133b-498a-9034-a2b1e1222068
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	c38c4d4c-ebe0-48eb-ad11-babc40aadf51
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	a387f0ac-9934-4045-9b66-519ab81a9fe8
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	6addefd0-745d-4089-889e-edfb860da155
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	47aef221-df08-45fc-8fc3-89c2919b85aa
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	1586c2d1-8a81-4af3-845e-cb1b295baae2
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	080f3382-84a4-40f1-90bf-0a88e5b621b5
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	219354f0-d7d7-4f48-9389-86f5835f5bbc
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	c300f004-3cc3-4335-82f8-a8135806fc44
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	cba175fd-d816-4c37-889d-173a85504723
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	9ba48941-8285-43fa-a7eb-1c890af65d8c
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	9e6b0557-72e1-472c-a858-50e576ec82d7
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	cc0eaf40-e913-4702-b7a3-bead91713dd4
600aa0fd-5ebe-4c8e-a057-619b3ccd7b56	9ba48941-8285-43fa-a7eb-1c890af65d8c
8deeeeb9-f4eb-44b4-9a17-c55acc586331	cba175fd-d816-4c37-889d-173a85504723
8deeeeb9-f4eb-44b4-9a17-c55acc586331	cc0eaf40-e913-4702-b7a3-bead91713dd4
1629bae3-a586-4f1e-85d3-a69cf6293877	6443841f-ab4a-408f-9ee4-e17216da745e
1629bae3-a586-4f1e-85d3-a69cf6293877	d9fc411a-cc9d-422c-b8b8-04380c86c032
d9fc411a-cc9d-422c-b8b8-04380c86c032	7116da90-4dd9-42ef-bbbe-099be9b0c61d
939137d2-24f9-4721-b3c6-d8664d171060	f6551ae5-b405-4a7f-8b27-2495d7e55f32
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	9c1733e3-703e-45f8-8ead-f746509c36b8
1629bae3-a586-4f1e-85d3-a69cf6293877	d9c58c0d-4b4c-4d64-ad8f-87e67af2298f
1629bae3-a586-4f1e-85d3-a69cf6293877	9c554909-4461-4b8a-8551-319e2655fd08
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	6e18066a-ac2a-4368-968c-8ddd07910e75
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	93e51c46-3b21-4fb0-a913-97b34b7f099a
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	1a5c7f1a-83f4-4b66-9b2f-f9246e762c65
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	562e0faf-7a36-4c0e-b706-d4cf28be468d
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	8496e0c7-4a8f-428b-bc7f-29cab9df15e8
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	524df443-d159-448b-aa63-637092278447
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	77b78112-9ea6-4895-af89-11f0e1fa7928
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	fa266a8d-93de-4d02-8f3e-4416b53ad34b
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	e216b7ad-f695-46fa-ac2c-3cf78ef7ef71
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	221c3d5d-fd73-4171-b343-b745b73d4eaf
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	519feebb-c1ef-4aef-a5de-5fde40e34a6f
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	0d636e88-2802-41dc-8be4-9a72e9cca544
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	bea16d6a-f483-4046-8663-0dd7ede5d21b
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	36eff77d-c453-47ab-be2a-0323476ef854
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	4947cfde-f84b-42fd-8ee8-edca407c1f22
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	392f0232-ed15-4439-b325-952b3cf75bc2
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	6f7086c4-bc86-4388-bb53-c048007c3731
562e0faf-7a36-4c0e-b706-d4cf28be468d	4947cfde-f84b-42fd-8ee8-edca407c1f22
1a5c7f1a-83f4-4b66-9b2f-f9246e762c65	36eff77d-c453-47ab-be2a-0323476ef854
1a5c7f1a-83f4-4b66-9b2f-f9246e762c65	6f7086c4-bc86-4388-bb53-c048007c3731
dfd0b3aa-6081-4584-83d9-0508f7a14205	3504d24a-7304-48a1-875a-572734c96419
dfd0b3aa-6081-4584-83d9-0508f7a14205	0babfd2e-ebe7-4040-a842-5740f47d5924
dfd0b3aa-6081-4584-83d9-0508f7a14205	e3e49d04-feda-4416-ba12-b6f0a91400ff
dfd0b3aa-6081-4584-83d9-0508f7a14205	d011f655-387a-4f0f-b561-7e986d570b7c
dfd0b3aa-6081-4584-83d9-0508f7a14205	bca41df5-0ebf-4b1e-8109-a36505a67d9f
dfd0b3aa-6081-4584-83d9-0508f7a14205	9af15575-13f7-4da0-8d06-61e2f042a61b
dfd0b3aa-6081-4584-83d9-0508f7a14205	b3b5a674-b64f-41fa-ae9a-f020acf2bba7
dfd0b3aa-6081-4584-83d9-0508f7a14205	b2bc19de-cc87-471c-9ff9-06d05d18e26d
dfd0b3aa-6081-4584-83d9-0508f7a14205	e44ee885-5a63-4fd6-b471-12daa483be65
dfd0b3aa-6081-4584-83d9-0508f7a14205	eba58450-be6f-4785-b3c5-289fe478b0d0
dfd0b3aa-6081-4584-83d9-0508f7a14205	29a4096b-f785-4f12-9dd2-91e5a56178cb
dfd0b3aa-6081-4584-83d9-0508f7a14205	1bc80160-9426-4e35-8c19-3387600947ec
dfd0b3aa-6081-4584-83d9-0508f7a14205	ac37d37d-8709-4448-96b3-5440c091ae7c
dfd0b3aa-6081-4584-83d9-0508f7a14205	d15f1c52-14a9-48a4-a9ee-d1316ab7b219
dfd0b3aa-6081-4584-83d9-0508f7a14205	6135d573-ecc7-4093-a77d-537d1d99e93a
dfd0b3aa-6081-4584-83d9-0508f7a14205	01db9550-9c6c-4b54-bcdf-36375297bacf
dfd0b3aa-6081-4584-83d9-0508f7a14205	e411811f-8923-4718-9650-639a84479479
d011f655-387a-4f0f-b561-7e986d570b7c	6135d573-ecc7-4093-a77d-537d1d99e93a
e3e49d04-feda-4416-ba12-b6f0a91400ff	e411811f-8923-4718-9650-639a84479479
e3e49d04-feda-4416-ba12-b6f0a91400ff	d15f1c52-14a9-48a4-a9ee-d1316ab7b219
5a586dd6-c63e-4af9-89eb-9e968e82f499	abb44df7-5290-43a0-a132-f36e66faf63d
5a586dd6-c63e-4af9-89eb-9e968e82f499	aa8286cc-13c6-445d-b8ca-f9f355e22640
aa8286cc-13c6-445d-b8ca-f9f355e22640	a0f78644-c775-4dbf-9a16-8ebd816444b7
ff527d46-24af-407d-9b94-ad8d1e439e07	4ce809da-6a17-4456-9a28-dd9d6fc20210
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	36be3fa5-6147-4200-b44d-a556e2b6078a
dfd0b3aa-6081-4584-83d9-0508f7a14205	18c53197-7bd6-47e6-b765-5c5a7d4d1a19
5a586dd6-c63e-4af9-89eb-9e968e82f499	6a982c81-2821-489a-b5b4-6e2ea787fd7e
5a586dd6-c63e-4af9-89eb-9e968e82f499	62973b82-21b2-4448-a23c-2b417e2af255
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
0fd13353-12c2-461d-86ec-4ec20b1e80b5	\N	password	2625de39-4ad0-41fa-9fe1-be10682191a8	1635345630039	\N	{"value":"MJyM0lAAZJayeku3cZC7lBy3MH6BrE0+ohru0b89HNnPRw5XVSKNn5cmw3apZWKc0QPAX3WGfZAFs1MN8IVyZQ==","salt":"oNbhonu+x/tN0cYb15Azow==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
59578cbf-70a7-4b70-86dd-c19436598087	\N	password	d5c5caf0-f208-4028-b1d9-0595aa3847e6	1635864709524	\N	{"value":"n2GVf4EJgFsY6dzz9gwMMEKO28AlqN4/Nin9s0cuh+xi7Btl9v0LWUyZmC7x/5usZEvLPh+N1uqBV92CHNJx/A==","salt":"yoTvCZMw7OPbt+wj0HIa9w==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-10-27 14:40:16.225622	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5345615388
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-10-27 14:40:16.248659	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5345615388
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-10-27 14:40:16.338278	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	5345615388
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-10-27 14:40:16.34779	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5345615388
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-10-27 14:40:16.588612	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5345615388
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-10-27 14:40:16.600344	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5345615388
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-10-27 14:40:16.889064	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5345615388
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-10-27 14:40:16.901841	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5345615388
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-10-27 14:40:16.930273	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	5345615388
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-10-27 14:40:17.370197	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	5345615388
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-10-27 14:40:17.890328	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5345615388
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-10-27 14:40:17.902118	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5345615388
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-10-27 14:40:17.976795	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5345615388
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-27 14:40:18.103231	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	5345615388
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-27 14:40:18.110018	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5345615388
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-27 14:40:18.117896	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	5345615388
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-27 14:40:18.123183	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	5345615388
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-10-27 14:40:18.3277	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	5345615388
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-10-27 14:40:18.471016	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5345615388
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-10-27 14:40:18.490824	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5345615388
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-27 14:40:22.361834	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5345615388
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-27 14:40:18.499138	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5345615388
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-27 14:40:18.507673	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5345615388
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-10-27 14:40:18.603022	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	5345615388
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-10-27 14:40:18.633314	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5345615388
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-10-27 14:40:18.638788	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5345615388
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-10-27 14:40:19.179369	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	5345615388
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-10-27 14:40:19.561304	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	5345615388
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-10-27 14:40:19.573569	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5345615388
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-10-27 14:40:19.899553	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	5345615388
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-10-27 14:40:19.953814	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	5345615388
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-10-27 14:40:20.006939	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	5345615388
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-10-27 14:40:20.018648	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	5345615388
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-27 14:40:20.055414	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5345615388
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-27 14:40:20.06288	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5345615388
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-27 14:40:20.187519	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5345615388
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-10-27 14:40:20.203563	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	5345615388
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-27 14:40:20.231091	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5345615388
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-10-27 14:40:20.242117	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	5345615388
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-10-27 14:40:20.254796	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	5345615388
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-27 14:40:20.25886	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5345615388
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-27 14:40:20.263688	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5345615388
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-10-27 14:40:20.272753	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	5345615388
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-27 14:40:22.329024	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	5345615388
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-10-27 14:40:22.343067	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	5345615388
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-27 14:40:22.370975	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	5345615388
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-27 14:40:22.37993	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5345615388
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-27 14:40:22.535911	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	5345615388
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-27 14:40:22.544353	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	5345615388
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-10-27 14:40:22.655948	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	5345615388
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-10-27 14:40:22.993995	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	5345615388
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-10-27 14:40:23.013655	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5345615388
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-10-27 14:40:23.025809	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	5345615388
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-10-27 14:40:23.035964	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	5345615388
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-27 14:40:23.090826	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	5345615388
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-27 14:40:23.105052	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	5345615388
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-27 14:40:23.219138	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	5345615388
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-27 14:40:23.569893	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	5345615388
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-10-27 14:40:23.617831	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	5345615388
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-10-27 14:40:23.632708	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5345615388
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-27 14:40:23.647643	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	5345615388
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-27 14:40:23.67556	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	5345615388
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-10-27 14:40:23.69058	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5345615388
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-10-27 14:40:23.695771	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5345615388
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-27 14:40:23.704612	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	5345615388
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-10-27 14:40:23.788051	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	5345615388
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-27 14:40:23.828837	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	5345615388
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-10-27 14:40:23.840278	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	5345615388
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-10-27 14:40:23.875315	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	5345615388
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-10-27 14:40:23.884316	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	5345615388
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-10-27 14:40:23.892938	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	5345615388
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-27 14:40:23.906597	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5345615388
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-27 14:40:23.928566	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5345615388
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-27 14:40:23.931854	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5345615388
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-27 14:40:23.956292	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	5345615388
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-27 14:40:23.99985	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	5345615388
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-27 14:40:24.009284	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	5345615388
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-27 14:40:24.01714	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	5345615388
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-27 14:40:24.059575	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	5345615388
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-27 14:40:24.064531	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	5345615388
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-27 14:40:24.102315	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	5345615388
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-27 14:40:24.106144	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5345615388
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-27 14:40:24.114289	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5345615388
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-27 14:40:24.118069	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5345615388
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-27 14:40:24.144483	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5345615388
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-10-27 14:40:24.153368	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	5345615388
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-27 14:40:24.163039	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	5345615388
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-27 14:40:24.180994	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	5345615388
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.190986	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	5345615388
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.199544	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	5345615388
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.223287	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5345615388
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.233121	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	5345615388
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.236692	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	5345615388
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.249928	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	5345615388
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.253761	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	5345615388
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-27 14:40:24.261068	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	5345615388
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-27 14:40:24.338034	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5345615388
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-27 14:40:24.341221	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5345615388
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-27 14:40:24.354341	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5345615388
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-27 14:40:24.381789	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5345615388
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-27 14:40:24.385746	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5345615388
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-27 14:40:24.411286	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	5345615388
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-27 14:40:24.416798	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	5345615388
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2021-10-27 14:40:24.424347	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	5345615388
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	0757b8b5-0b09-4c77-8358-f20ce8468da4	f
master	b9b59c44-e482-4cc0-82a1-91aca2c8143b	t
master	542791a0-80e8-4535-8cd0-e5680e9eed8c	t
master	42a88c85-d923-43b9-8417-ce5c89f98ba8	t
master	afc8438b-9184-4870-a083-b09d5f37a0e2	f
master	69832938-6658-4dd1-af68-e982e260d52d	f
master	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52	t
master	f139048f-649a-4300-b2bd-6e05734ffd95	t
master	4591f0ae-402b-4aff-88d9-541e221b8e76	f
redream	9629a832-ce9a-4124-8a38-e2eb6aeb1a7a	f
redream	022c9d07-6367-43bd-b6bb-5bc071a5e31a	t
redream	546a8fee-dc9a-4826-b291-ed68c2674afa	t
redream	976ff401-7b1f-4976-889d-93601ea1a211	t
redream	5b2359a5-930b-4ee9-a76e-0b2742d35b98	f
redream	cf12891b-51a2-4cba-9cc2-296605edee1c	f
redream	e4b473b2-4160-4b39-b488-68d4de1e413c	t
redream	dec85a50-899d-4359-838d-615b03bdc17b	t
redream	4eba81b0-c260-45eb-bbfd-738c89937b31	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
1629bae3-a586-4f1e-85d3-a69cf6293877	master	f	${role_default-roles}	default-roles-master	master	\N	\N
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	master	f	${role_admin}	admin	master	\N	\N
f91929ba-dfe3-4598-97af-2ae49a27cff4	master	f	${role_create-realm}	create-realm	master	\N	\N
7ebe6665-a39b-4feb-9154-6cfeb10b05ef	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_create-client}	create-client	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
fd30e128-b3b2-4e07-9034-de21a5be429d	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_view-realm}	view-realm	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
8deeeeb9-f4eb-44b4-9a17-c55acc586331	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_view-users}	view-users	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
600aa0fd-5ebe-4c8e-a057-619b3ccd7b56	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_view-clients}	view-clients	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
dc2cbc18-133b-498a-9034-a2b1e1222068	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_view-events}	view-events	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
c38c4d4c-ebe0-48eb-ad11-babc40aadf51	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_view-identity-providers}	view-identity-providers	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
a387f0ac-9934-4045-9b66-519ab81a9fe8	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_view-authorization}	view-authorization	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
6addefd0-745d-4089-889e-edfb860da155	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_manage-realm}	manage-realm	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
47aef221-df08-45fc-8fc3-89c2919b85aa	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_manage-users}	manage-users	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
1586c2d1-8a81-4af3-845e-cb1b295baae2	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_manage-clients}	manage-clients	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
080f3382-84a4-40f1-90bf-0a88e5b621b5	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_manage-events}	manage-events	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
219354f0-d7d7-4f48-9389-86f5835f5bbc	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_manage-identity-providers}	manage-identity-providers	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
c300f004-3cc3-4335-82f8-a8135806fc44	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_manage-authorization}	manage-authorization	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
cba175fd-d816-4c37-889d-173a85504723	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_query-users}	query-users	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
9ba48941-8285-43fa-a7eb-1c890af65d8c	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_query-clients}	query-clients	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
9e6b0557-72e1-472c-a858-50e576ec82d7	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_query-realms}	query-realms	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
cc0eaf40-e913-4702-b7a3-bead91713dd4	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_query-groups}	query-groups	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
6443841f-ab4a-408f-9ee4-e17216da745e	0048bf46-9656-454b-a8f0-09fbea68c71d	t	${role_view-profile}	view-profile	master	0048bf46-9656-454b-a8f0-09fbea68c71d	\N
d9fc411a-cc9d-422c-b8b8-04380c86c032	0048bf46-9656-454b-a8f0-09fbea68c71d	t	${role_manage-account}	manage-account	master	0048bf46-9656-454b-a8f0-09fbea68c71d	\N
7116da90-4dd9-42ef-bbbe-099be9b0c61d	0048bf46-9656-454b-a8f0-09fbea68c71d	t	${role_manage-account-links}	manage-account-links	master	0048bf46-9656-454b-a8f0-09fbea68c71d	\N
ab105972-eff3-4b79-bfdc-fa4889a94853	0048bf46-9656-454b-a8f0-09fbea68c71d	t	${role_view-applications}	view-applications	master	0048bf46-9656-454b-a8f0-09fbea68c71d	\N
f6551ae5-b405-4a7f-8b27-2495d7e55f32	0048bf46-9656-454b-a8f0-09fbea68c71d	t	${role_view-consent}	view-consent	master	0048bf46-9656-454b-a8f0-09fbea68c71d	\N
939137d2-24f9-4721-b3c6-d8664d171060	0048bf46-9656-454b-a8f0-09fbea68c71d	t	${role_manage-consent}	manage-consent	master	0048bf46-9656-454b-a8f0-09fbea68c71d	\N
922234a2-bb68-4155-9299-3d9aedef8ea4	0048bf46-9656-454b-a8f0-09fbea68c71d	t	${role_delete-account}	delete-account	master	0048bf46-9656-454b-a8f0-09fbea68c71d	\N
5fbd6c84-60e5-4699-bad8-f138c4d19147	10385b68-bb2b-4d4d-b01f-f54ac422fd8d	t	${role_read-token}	read-token	master	10385b68-bb2b-4d4d-b01f-f54ac422fd8d	\N
9c1733e3-703e-45f8-8ead-f746509c36b8	d9564f2c-1863-4b16-84b1-3ec5a2eede05	t	${role_impersonation}	impersonation	master	d9564f2c-1863-4b16-84b1-3ec5a2eede05	\N
d9c58c0d-4b4c-4d64-ad8f-87e67af2298f	master	f	${role_offline-access}	offline_access	master	\N	\N
9c554909-4461-4b8a-8551-319e2655fd08	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
5a586dd6-c63e-4af9-89eb-9e968e82f499	redream	f	${role_default-roles}	default-roles-redream	redream	\N	\N
6e18066a-ac2a-4368-968c-8ddd07910e75	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_create-client}	create-client	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
93e51c46-3b21-4fb0-a913-97b34b7f099a	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_view-realm}	view-realm	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
1a5c7f1a-83f4-4b66-9b2f-f9246e762c65	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_view-users}	view-users	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
562e0faf-7a36-4c0e-b706-d4cf28be468d	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_view-clients}	view-clients	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
8496e0c7-4a8f-428b-bc7f-29cab9df15e8	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_view-events}	view-events	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
524df443-d159-448b-aa63-637092278447	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_view-identity-providers}	view-identity-providers	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
77b78112-9ea6-4895-af89-11f0e1fa7928	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_view-authorization}	view-authorization	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
fa266a8d-93de-4d02-8f3e-4416b53ad34b	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_manage-realm}	manage-realm	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
e216b7ad-f695-46fa-ac2c-3cf78ef7ef71	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_manage-users}	manage-users	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
221c3d5d-fd73-4171-b343-b745b73d4eaf	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_manage-clients}	manage-clients	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
519feebb-c1ef-4aef-a5de-5fde40e34a6f	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_manage-events}	manage-events	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
0d636e88-2802-41dc-8be4-9a72e9cca544	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_manage-identity-providers}	manage-identity-providers	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
bea16d6a-f483-4046-8663-0dd7ede5d21b	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_manage-authorization}	manage-authorization	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
36eff77d-c453-47ab-be2a-0323476ef854	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_query-users}	query-users	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
4947cfde-f84b-42fd-8ee8-edca407c1f22	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_query-clients}	query-clients	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
392f0232-ed15-4439-b325-952b3cf75bc2	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_query-realms}	query-realms	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
6f7086c4-bc86-4388-bb53-c048007c3731	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_query-groups}	query-groups	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
dfd0b3aa-6081-4584-83d9-0508f7a14205	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_realm-admin}	realm-admin	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
3504d24a-7304-48a1-875a-572734c96419	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_create-client}	create-client	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
0babfd2e-ebe7-4040-a842-5740f47d5924	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_view-realm}	view-realm	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
e3e49d04-feda-4416-ba12-b6f0a91400ff	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_view-users}	view-users	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
d011f655-387a-4f0f-b561-7e986d570b7c	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_view-clients}	view-clients	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
bca41df5-0ebf-4b1e-8109-a36505a67d9f	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_view-events}	view-events	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
9af15575-13f7-4da0-8d06-61e2f042a61b	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_view-identity-providers}	view-identity-providers	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
b3b5a674-b64f-41fa-ae9a-f020acf2bba7	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_view-authorization}	view-authorization	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
b2bc19de-cc87-471c-9ff9-06d05d18e26d	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_manage-realm}	manage-realm	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
e44ee885-5a63-4fd6-b471-12daa483be65	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_manage-users}	manage-users	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
eba58450-be6f-4785-b3c5-289fe478b0d0	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_manage-clients}	manage-clients	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
29a4096b-f785-4f12-9dd2-91e5a56178cb	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_manage-events}	manage-events	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
1bc80160-9426-4e35-8c19-3387600947ec	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_manage-identity-providers}	manage-identity-providers	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
ac37d37d-8709-4448-96b3-5440c091ae7c	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_manage-authorization}	manage-authorization	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
d15f1c52-14a9-48a4-a9ee-d1316ab7b219	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_query-users}	query-users	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
6135d573-ecc7-4093-a77d-537d1d99e93a	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_query-clients}	query-clients	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
01db9550-9c6c-4b54-bcdf-36375297bacf	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_query-realms}	query-realms	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
e411811f-8923-4718-9650-639a84479479	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_query-groups}	query-groups	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
abb44df7-5290-43a0-a132-f36e66faf63d	c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	${role_view-profile}	view-profile	redream	c447134d-ed4a-45ed-86e4-8ef31e4e712b	\N
aa8286cc-13c6-445d-b8ca-f9f355e22640	c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	${role_manage-account}	manage-account	redream	c447134d-ed4a-45ed-86e4-8ef31e4e712b	\N
a0f78644-c775-4dbf-9a16-8ebd816444b7	c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	${role_manage-account-links}	manage-account-links	redream	c447134d-ed4a-45ed-86e4-8ef31e4e712b	\N
847c6d7f-578f-41ec-839c-8243d0b4a560	c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	${role_view-applications}	view-applications	redream	c447134d-ed4a-45ed-86e4-8ef31e4e712b	\N
4ce809da-6a17-4456-9a28-dd9d6fc20210	c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	${role_view-consent}	view-consent	redream	c447134d-ed4a-45ed-86e4-8ef31e4e712b	\N
ff527d46-24af-407d-9b94-ad8d1e439e07	c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	${role_manage-consent}	manage-consent	redream	c447134d-ed4a-45ed-86e4-8ef31e4e712b	\N
7a65cf14-13f2-476d-89a0-3d0b28fff251	c447134d-ed4a-45ed-86e4-8ef31e4e712b	t	${role_delete-account}	delete-account	redream	c447134d-ed4a-45ed-86e4-8ef31e4e712b	\N
36be3fa5-6147-4200-b44d-a556e2b6078a	62e4a9dc-894a-423c-97df-31e9138dc034	t	${role_impersonation}	impersonation	master	62e4a9dc-894a-423c-97df-31e9138dc034	\N
18c53197-7bd6-47e6-b765-5c5a7d4d1a19	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	t	${role_impersonation}	impersonation	redream	979edf1d-6fda-4cf7-9eb6-3450aebe79fe	\N
8d30ed11-825c-4178-8b98-d86734f0aadd	c9f7f839-967a-4f53-9fca-2f77c001cd6e	t	${role_read-token}	read-token	redream	c9f7f839-967a-4f53-9fca-2f77c001cd6e	\N
6a982c81-2821-489a-b5b4-6e2ea787fd7e	redream	f	${role_offline-access}	offline_access	redream	\N	\N
62973b82-21b2-4448-a23c-2b417e2af255	redream	f	${role_uma_authorization}	uma_authorization	redream	\N	\N
68b3fb89-2aee-46c0-8ad4-b3d817c40562	redream	f	\N	VEHICLE	redream	\N	\N
15f2c5b8-f958-43e4-bc7f-e5a33a5738a0	redream	f	\N	ENERGY	redream	\N	\N
fee70758-1cc7-44d7-9fec-b7855b60acd9	redream	f	\N	ROUTING	redream	\N	\N
1ac09382-c08e-4954-9c18-f5cde8d0463a	b39939b2-0ddb-441a-a9c2-e24fdde29f44	t	\N	ENERGY	redream	b39939b2-0ddb-441a-a9c2-e24fdde29f44	\N
f2e91caf-9098-4965-9aa1-36f23c2c4dcc	b39939b2-0ddb-441a-a9c2-e24fdde29f44	t	\N	ROUTING	redream	b39939b2-0ddb-441a-a9c2-e24fdde29f44	\N
b53dac72-1dbe-4c92-974e-168437883604	b39939b2-0ddb-441a-a9c2-e24fdde29f44	t	\N	VEHICLE	redream	b39939b2-0ddb-441a-a9c2-e24fdde29f44	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ddfvn	15.0.2	1635345628
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
b76db624-8362-45ed-9b67-73ad5a8897ac	audience resolve	openid-connect	oidc-audience-resolve-mapper	f55de89e-645b-4f63-8933-5fb1620f98df	\N
91c0722a-b811-420d-806b-91db1b3376e7	locale	openid-connect	oidc-usermodel-attribute-mapper	24fa11d7-0545-439d-8137-c281a5e2691b	\N
048c55f1-f230-483c-909e-635740eadb36	role list	saml	saml-role-list-mapper	\N	b9b59c44-e482-4cc0-82a1-91aca2c8143b
8b7dd18e-4d66-4b5d-8e54-c52dc2c27969	full name	openid-connect	oidc-full-name-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
49772335-9bdd-47c4-99a9-ec40395ab072	family name	openid-connect	oidc-usermodel-property-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
3b4850a1-8239-4f2d-ab4e-c922f1b4bfd8	given name	openid-connect	oidc-usermodel-property-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
d16efe88-9954-41b3-a016-2daab3dbe333	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
92f1f688-5f65-4306-beac-f30cdaf21980	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
524323dc-3cfa-41c9-b980-eabfb3eed30b	username	openid-connect	oidc-usermodel-property-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
5010d526-27a5-4f4e-8e83-52cdcd0e05b1	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
d0a227ce-227a-4dba-aa4c-bddb990ad289	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
ddfb153a-2aec-41fc-8807-503335d11a55	website	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
0dc262e2-3008-4fab-a51d-0f046042b01b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
c34c2edd-79a2-42d2-a74d-31cf0582deee	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
f0c33a43-5d09-4016-bed4-01de2ae81262	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
f2adde31-5806-4d43-922f-cce6acba7ea6	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
55756374-674a-40e9-a674-50a7da323921	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	542791a0-80e8-4535-8cd0-e5680e9eed8c
a5615976-addb-432d-962e-ea154983e520	email	openid-connect	oidc-usermodel-property-mapper	\N	42a88c85-d923-43b9-8417-ce5c89f98ba8
dd7dd215-416e-4248-b007-c460c03f08bf	email verified	openid-connect	oidc-usermodel-property-mapper	\N	42a88c85-d923-43b9-8417-ce5c89f98ba8
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	address	openid-connect	oidc-address-mapper	\N	afc8438b-9184-4870-a083-b09d5f37a0e2
24d70c64-e576-4524-baa7-6666c3a7444b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	69832938-6658-4dd1-af68-e982e260d52d
57e11116-7b55-47af-bd02-9b5726b1fd01	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	69832938-6658-4dd1-af68-e982e260d52d
904f5323-3061-4b67-9bfd-e146d90d4ea4	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52
77419071-37fe-4485-a2f7-55b3486ba436	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52
a8057544-3a39-4455-a574-e49d15c0ca18	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	9df4f08e-86c7-4d71-b9dc-adaef1b0bc52
0bd2adf8-54d2-4dc0-bf2b-d96379f492d3	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	f139048f-649a-4300-b2bd-6e05734ffd95
5e1d31ab-d17a-454b-aa56-70a9b01b6dbf	upn	openid-connect	oidc-usermodel-property-mapper	\N	4591f0ae-402b-4aff-88d9-541e221b8e76
ff882204-9792-47b5-8e63-ae25fe049324	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	4591f0ae-402b-4aff-88d9-541e221b8e76
8bc54643-fdad-43eb-88bf-e5947cfa43ec	audience resolve	openid-connect	oidc-audience-resolve-mapper	1590b1b3-f267-40ab-827d-e0d5e1d69f42	\N
3b64125b-7812-4698-b706-4a2dc08531c2	role list	saml	saml-role-list-mapper	\N	022c9d07-6367-43bd-b6bb-5bc071a5e31a
0deb787d-820e-4461-8ed5-e711060ed5f7	full name	openid-connect	oidc-full-name-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
45b7b453-8ae8-4bbb-937b-fd7e6546fa91	family name	openid-connect	oidc-usermodel-property-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
5bb8ec42-fe6a-4a11-bca0-9434f2be8e9d	given name	openid-connect	oidc-usermodel-property-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
5db2d222-a962-4d09-a55c-820f32c36706	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
e54297b7-9e26-439d-8736-7dd8317ea00d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
c09406dc-9e25-453d-b394-54f8f1252175	username	openid-connect	oidc-usermodel-property-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
c0b1cc11-3210-4fd2-b5e7-5ea2920d128c	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
1b846b3f-1b91-4705-a00d-bf012e58242b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
98654800-8ec7-4ca2-9d4e-f5d8597e00d7	website	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
01650d7b-3515-4e0e-9085-8be0c6d515a2	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
419e6601-463c-4dfa-a4e8-513b96b4b9f5	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
f97f4535-599a-49cc-8096-606bc5604e77	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
20e675c9-7739-4b2e-819c-15e9de6d99bc	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
53ef6bc8-4033-4f53-9e07-a74d9f952692	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	546a8fee-dc9a-4826-b291-ed68c2674afa
b1ce2e16-aabb-4a51-a9e7-38dbf285ad0f	email	openid-connect	oidc-usermodel-property-mapper	\N	976ff401-7b1f-4976-889d-93601ea1a211
4f486ea5-3e64-45f0-9c72-51fafc0b50a3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	976ff401-7b1f-4976-889d-93601ea1a211
dfe03972-302b-44f8-89e3-f8632f3730dc	address	openid-connect	oidc-address-mapper	\N	5b2359a5-930b-4ee9-a76e-0b2742d35b98
e69b0378-67c9-4f1f-a73e-e96cb021e608	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	cf12891b-51a2-4cba-9cc2-296605edee1c
5ee0e909-c103-4482-b76f-dc3073376af6	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	cf12891b-51a2-4cba-9cc2-296605edee1c
669656b6-6e39-4af4-bd2d-c6c6305c2bd9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e4b473b2-4160-4b39-b488-68d4de1e413c
00890afc-ce2e-4c6c-a5b2-5c49a8582c10	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e4b473b2-4160-4b39-b488-68d4de1e413c
4719b737-2ddd-4521-97e6-2d4418348e6c	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e4b473b2-4160-4b39-b488-68d4de1e413c
eb8e02e2-3d9d-417f-9cdd-3ab97091a64c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	dec85a50-899d-4359-838d-615b03bdc17b
4b50543f-6b21-43c4-8936-cab0e3a9db83	upn	openid-connect	oidc-usermodel-property-mapper	\N	4eba81b0-c260-45eb-bbfd-738c89937b31
d9157ba0-88c0-4003-8483-4f55d7eb6a5f	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	4eba81b0-c260-45eb-bbfd-738c89937b31
655759a7-0ebe-4bba-aa6a-9c73fef4ddb6	locale	openid-connect	oidc-usermodel-attribute-mapper	e2fd7fda-86b0-4101-bd79-07dd61d9881b	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
91c0722a-b811-420d-806b-91db1b3376e7	true	userinfo.token.claim
91c0722a-b811-420d-806b-91db1b3376e7	locale	user.attribute
91c0722a-b811-420d-806b-91db1b3376e7	true	id.token.claim
91c0722a-b811-420d-806b-91db1b3376e7	true	access.token.claim
91c0722a-b811-420d-806b-91db1b3376e7	locale	claim.name
91c0722a-b811-420d-806b-91db1b3376e7	String	jsonType.label
048c55f1-f230-483c-909e-635740eadb36	false	single
048c55f1-f230-483c-909e-635740eadb36	Basic	attribute.nameformat
048c55f1-f230-483c-909e-635740eadb36	Role	attribute.name
8b7dd18e-4d66-4b5d-8e54-c52dc2c27969	true	userinfo.token.claim
8b7dd18e-4d66-4b5d-8e54-c52dc2c27969	true	id.token.claim
8b7dd18e-4d66-4b5d-8e54-c52dc2c27969	true	access.token.claim
49772335-9bdd-47c4-99a9-ec40395ab072	true	userinfo.token.claim
49772335-9bdd-47c4-99a9-ec40395ab072	lastName	user.attribute
49772335-9bdd-47c4-99a9-ec40395ab072	true	id.token.claim
49772335-9bdd-47c4-99a9-ec40395ab072	true	access.token.claim
49772335-9bdd-47c4-99a9-ec40395ab072	family_name	claim.name
49772335-9bdd-47c4-99a9-ec40395ab072	String	jsonType.label
3b4850a1-8239-4f2d-ab4e-c922f1b4bfd8	true	userinfo.token.claim
3b4850a1-8239-4f2d-ab4e-c922f1b4bfd8	firstName	user.attribute
3b4850a1-8239-4f2d-ab4e-c922f1b4bfd8	true	id.token.claim
3b4850a1-8239-4f2d-ab4e-c922f1b4bfd8	true	access.token.claim
3b4850a1-8239-4f2d-ab4e-c922f1b4bfd8	given_name	claim.name
3b4850a1-8239-4f2d-ab4e-c922f1b4bfd8	String	jsonType.label
d16efe88-9954-41b3-a016-2daab3dbe333	true	userinfo.token.claim
d16efe88-9954-41b3-a016-2daab3dbe333	middleName	user.attribute
d16efe88-9954-41b3-a016-2daab3dbe333	true	id.token.claim
d16efe88-9954-41b3-a016-2daab3dbe333	true	access.token.claim
d16efe88-9954-41b3-a016-2daab3dbe333	middle_name	claim.name
d16efe88-9954-41b3-a016-2daab3dbe333	String	jsonType.label
92f1f688-5f65-4306-beac-f30cdaf21980	true	userinfo.token.claim
92f1f688-5f65-4306-beac-f30cdaf21980	nickname	user.attribute
92f1f688-5f65-4306-beac-f30cdaf21980	true	id.token.claim
92f1f688-5f65-4306-beac-f30cdaf21980	true	access.token.claim
92f1f688-5f65-4306-beac-f30cdaf21980	nickname	claim.name
92f1f688-5f65-4306-beac-f30cdaf21980	String	jsonType.label
524323dc-3cfa-41c9-b980-eabfb3eed30b	true	userinfo.token.claim
524323dc-3cfa-41c9-b980-eabfb3eed30b	username	user.attribute
524323dc-3cfa-41c9-b980-eabfb3eed30b	true	id.token.claim
524323dc-3cfa-41c9-b980-eabfb3eed30b	true	access.token.claim
524323dc-3cfa-41c9-b980-eabfb3eed30b	preferred_username	claim.name
524323dc-3cfa-41c9-b980-eabfb3eed30b	String	jsonType.label
5010d526-27a5-4f4e-8e83-52cdcd0e05b1	true	userinfo.token.claim
5010d526-27a5-4f4e-8e83-52cdcd0e05b1	profile	user.attribute
5010d526-27a5-4f4e-8e83-52cdcd0e05b1	true	id.token.claim
5010d526-27a5-4f4e-8e83-52cdcd0e05b1	true	access.token.claim
5010d526-27a5-4f4e-8e83-52cdcd0e05b1	profile	claim.name
5010d526-27a5-4f4e-8e83-52cdcd0e05b1	String	jsonType.label
d0a227ce-227a-4dba-aa4c-bddb990ad289	true	userinfo.token.claim
d0a227ce-227a-4dba-aa4c-bddb990ad289	picture	user.attribute
d0a227ce-227a-4dba-aa4c-bddb990ad289	true	id.token.claim
d0a227ce-227a-4dba-aa4c-bddb990ad289	true	access.token.claim
d0a227ce-227a-4dba-aa4c-bddb990ad289	picture	claim.name
d0a227ce-227a-4dba-aa4c-bddb990ad289	String	jsonType.label
ddfb153a-2aec-41fc-8807-503335d11a55	true	userinfo.token.claim
ddfb153a-2aec-41fc-8807-503335d11a55	website	user.attribute
ddfb153a-2aec-41fc-8807-503335d11a55	true	id.token.claim
ddfb153a-2aec-41fc-8807-503335d11a55	true	access.token.claim
ddfb153a-2aec-41fc-8807-503335d11a55	website	claim.name
ddfb153a-2aec-41fc-8807-503335d11a55	String	jsonType.label
0dc262e2-3008-4fab-a51d-0f046042b01b	true	userinfo.token.claim
0dc262e2-3008-4fab-a51d-0f046042b01b	gender	user.attribute
0dc262e2-3008-4fab-a51d-0f046042b01b	true	id.token.claim
0dc262e2-3008-4fab-a51d-0f046042b01b	true	access.token.claim
0dc262e2-3008-4fab-a51d-0f046042b01b	gender	claim.name
0dc262e2-3008-4fab-a51d-0f046042b01b	String	jsonType.label
c34c2edd-79a2-42d2-a74d-31cf0582deee	true	userinfo.token.claim
c34c2edd-79a2-42d2-a74d-31cf0582deee	birthdate	user.attribute
c34c2edd-79a2-42d2-a74d-31cf0582deee	true	id.token.claim
c34c2edd-79a2-42d2-a74d-31cf0582deee	true	access.token.claim
c34c2edd-79a2-42d2-a74d-31cf0582deee	birthdate	claim.name
c34c2edd-79a2-42d2-a74d-31cf0582deee	String	jsonType.label
f0c33a43-5d09-4016-bed4-01de2ae81262	true	userinfo.token.claim
f0c33a43-5d09-4016-bed4-01de2ae81262	zoneinfo	user.attribute
f0c33a43-5d09-4016-bed4-01de2ae81262	true	id.token.claim
f0c33a43-5d09-4016-bed4-01de2ae81262	true	access.token.claim
f0c33a43-5d09-4016-bed4-01de2ae81262	zoneinfo	claim.name
f0c33a43-5d09-4016-bed4-01de2ae81262	String	jsonType.label
f2adde31-5806-4d43-922f-cce6acba7ea6	true	userinfo.token.claim
f2adde31-5806-4d43-922f-cce6acba7ea6	locale	user.attribute
f2adde31-5806-4d43-922f-cce6acba7ea6	true	id.token.claim
f2adde31-5806-4d43-922f-cce6acba7ea6	true	access.token.claim
f2adde31-5806-4d43-922f-cce6acba7ea6	locale	claim.name
f2adde31-5806-4d43-922f-cce6acba7ea6	String	jsonType.label
55756374-674a-40e9-a674-50a7da323921	true	userinfo.token.claim
55756374-674a-40e9-a674-50a7da323921	updatedAt	user.attribute
55756374-674a-40e9-a674-50a7da323921	true	id.token.claim
55756374-674a-40e9-a674-50a7da323921	true	access.token.claim
55756374-674a-40e9-a674-50a7da323921	updated_at	claim.name
55756374-674a-40e9-a674-50a7da323921	String	jsonType.label
a5615976-addb-432d-962e-ea154983e520	true	userinfo.token.claim
a5615976-addb-432d-962e-ea154983e520	email	user.attribute
a5615976-addb-432d-962e-ea154983e520	true	id.token.claim
a5615976-addb-432d-962e-ea154983e520	true	access.token.claim
a5615976-addb-432d-962e-ea154983e520	email	claim.name
a5615976-addb-432d-962e-ea154983e520	String	jsonType.label
dd7dd215-416e-4248-b007-c460c03f08bf	true	userinfo.token.claim
dd7dd215-416e-4248-b007-c460c03f08bf	emailVerified	user.attribute
dd7dd215-416e-4248-b007-c460c03f08bf	true	id.token.claim
dd7dd215-416e-4248-b007-c460c03f08bf	true	access.token.claim
dd7dd215-416e-4248-b007-c460c03f08bf	email_verified	claim.name
dd7dd215-416e-4248-b007-c460c03f08bf	boolean	jsonType.label
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	formatted	user.attribute.formatted
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	country	user.attribute.country
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	postal_code	user.attribute.postal_code
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	true	userinfo.token.claim
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	street	user.attribute.street
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	true	id.token.claim
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	region	user.attribute.region
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	true	access.token.claim
963a236f-6ed9-44af-b8d5-8c69c3b4e5cf	locality	user.attribute.locality
24d70c64-e576-4524-baa7-6666c3a7444b	true	userinfo.token.claim
24d70c64-e576-4524-baa7-6666c3a7444b	phoneNumber	user.attribute
24d70c64-e576-4524-baa7-6666c3a7444b	true	id.token.claim
24d70c64-e576-4524-baa7-6666c3a7444b	true	access.token.claim
24d70c64-e576-4524-baa7-6666c3a7444b	phone_number	claim.name
24d70c64-e576-4524-baa7-6666c3a7444b	String	jsonType.label
57e11116-7b55-47af-bd02-9b5726b1fd01	true	userinfo.token.claim
57e11116-7b55-47af-bd02-9b5726b1fd01	phoneNumberVerified	user.attribute
57e11116-7b55-47af-bd02-9b5726b1fd01	true	id.token.claim
57e11116-7b55-47af-bd02-9b5726b1fd01	true	access.token.claim
57e11116-7b55-47af-bd02-9b5726b1fd01	phone_number_verified	claim.name
57e11116-7b55-47af-bd02-9b5726b1fd01	boolean	jsonType.label
904f5323-3061-4b67-9bfd-e146d90d4ea4	true	multivalued
904f5323-3061-4b67-9bfd-e146d90d4ea4	foo	user.attribute
904f5323-3061-4b67-9bfd-e146d90d4ea4	true	access.token.claim
904f5323-3061-4b67-9bfd-e146d90d4ea4	realm_access.roles	claim.name
904f5323-3061-4b67-9bfd-e146d90d4ea4	String	jsonType.label
77419071-37fe-4485-a2f7-55b3486ba436	true	multivalued
77419071-37fe-4485-a2f7-55b3486ba436	foo	user.attribute
77419071-37fe-4485-a2f7-55b3486ba436	true	access.token.claim
77419071-37fe-4485-a2f7-55b3486ba436	resource_access.${client_id}.roles	claim.name
77419071-37fe-4485-a2f7-55b3486ba436	String	jsonType.label
5e1d31ab-d17a-454b-aa56-70a9b01b6dbf	true	userinfo.token.claim
5e1d31ab-d17a-454b-aa56-70a9b01b6dbf	username	user.attribute
5e1d31ab-d17a-454b-aa56-70a9b01b6dbf	true	id.token.claim
5e1d31ab-d17a-454b-aa56-70a9b01b6dbf	true	access.token.claim
5e1d31ab-d17a-454b-aa56-70a9b01b6dbf	upn	claim.name
5e1d31ab-d17a-454b-aa56-70a9b01b6dbf	String	jsonType.label
ff882204-9792-47b5-8e63-ae25fe049324	true	multivalued
ff882204-9792-47b5-8e63-ae25fe049324	foo	user.attribute
ff882204-9792-47b5-8e63-ae25fe049324	true	id.token.claim
ff882204-9792-47b5-8e63-ae25fe049324	true	access.token.claim
ff882204-9792-47b5-8e63-ae25fe049324	groups	claim.name
ff882204-9792-47b5-8e63-ae25fe049324	String	jsonType.label
3b64125b-7812-4698-b706-4a2dc08531c2	false	single
3b64125b-7812-4698-b706-4a2dc08531c2	Basic	attribute.nameformat
3b64125b-7812-4698-b706-4a2dc08531c2	Role	attribute.name
0deb787d-820e-4461-8ed5-e711060ed5f7	true	userinfo.token.claim
0deb787d-820e-4461-8ed5-e711060ed5f7	true	id.token.claim
0deb787d-820e-4461-8ed5-e711060ed5f7	true	access.token.claim
45b7b453-8ae8-4bbb-937b-fd7e6546fa91	true	userinfo.token.claim
45b7b453-8ae8-4bbb-937b-fd7e6546fa91	lastName	user.attribute
45b7b453-8ae8-4bbb-937b-fd7e6546fa91	true	id.token.claim
45b7b453-8ae8-4bbb-937b-fd7e6546fa91	true	access.token.claim
45b7b453-8ae8-4bbb-937b-fd7e6546fa91	family_name	claim.name
45b7b453-8ae8-4bbb-937b-fd7e6546fa91	String	jsonType.label
5bb8ec42-fe6a-4a11-bca0-9434f2be8e9d	true	userinfo.token.claim
5bb8ec42-fe6a-4a11-bca0-9434f2be8e9d	firstName	user.attribute
5bb8ec42-fe6a-4a11-bca0-9434f2be8e9d	true	id.token.claim
5bb8ec42-fe6a-4a11-bca0-9434f2be8e9d	true	access.token.claim
5bb8ec42-fe6a-4a11-bca0-9434f2be8e9d	given_name	claim.name
5bb8ec42-fe6a-4a11-bca0-9434f2be8e9d	String	jsonType.label
5db2d222-a962-4d09-a55c-820f32c36706	true	userinfo.token.claim
5db2d222-a962-4d09-a55c-820f32c36706	middleName	user.attribute
5db2d222-a962-4d09-a55c-820f32c36706	true	id.token.claim
5db2d222-a962-4d09-a55c-820f32c36706	true	access.token.claim
5db2d222-a962-4d09-a55c-820f32c36706	middle_name	claim.name
5db2d222-a962-4d09-a55c-820f32c36706	String	jsonType.label
e54297b7-9e26-439d-8736-7dd8317ea00d	true	userinfo.token.claim
e54297b7-9e26-439d-8736-7dd8317ea00d	nickname	user.attribute
e54297b7-9e26-439d-8736-7dd8317ea00d	true	id.token.claim
e54297b7-9e26-439d-8736-7dd8317ea00d	true	access.token.claim
e54297b7-9e26-439d-8736-7dd8317ea00d	nickname	claim.name
e54297b7-9e26-439d-8736-7dd8317ea00d	String	jsonType.label
c09406dc-9e25-453d-b394-54f8f1252175	true	userinfo.token.claim
c09406dc-9e25-453d-b394-54f8f1252175	username	user.attribute
c09406dc-9e25-453d-b394-54f8f1252175	true	id.token.claim
c09406dc-9e25-453d-b394-54f8f1252175	true	access.token.claim
c09406dc-9e25-453d-b394-54f8f1252175	preferred_username	claim.name
c09406dc-9e25-453d-b394-54f8f1252175	String	jsonType.label
c0b1cc11-3210-4fd2-b5e7-5ea2920d128c	true	userinfo.token.claim
c0b1cc11-3210-4fd2-b5e7-5ea2920d128c	profile	user.attribute
c0b1cc11-3210-4fd2-b5e7-5ea2920d128c	true	id.token.claim
c0b1cc11-3210-4fd2-b5e7-5ea2920d128c	true	access.token.claim
c0b1cc11-3210-4fd2-b5e7-5ea2920d128c	profile	claim.name
c0b1cc11-3210-4fd2-b5e7-5ea2920d128c	String	jsonType.label
1b846b3f-1b91-4705-a00d-bf012e58242b	true	userinfo.token.claim
1b846b3f-1b91-4705-a00d-bf012e58242b	picture	user.attribute
1b846b3f-1b91-4705-a00d-bf012e58242b	true	id.token.claim
1b846b3f-1b91-4705-a00d-bf012e58242b	true	access.token.claim
1b846b3f-1b91-4705-a00d-bf012e58242b	picture	claim.name
1b846b3f-1b91-4705-a00d-bf012e58242b	String	jsonType.label
98654800-8ec7-4ca2-9d4e-f5d8597e00d7	true	userinfo.token.claim
98654800-8ec7-4ca2-9d4e-f5d8597e00d7	website	user.attribute
98654800-8ec7-4ca2-9d4e-f5d8597e00d7	true	id.token.claim
98654800-8ec7-4ca2-9d4e-f5d8597e00d7	true	access.token.claim
98654800-8ec7-4ca2-9d4e-f5d8597e00d7	website	claim.name
98654800-8ec7-4ca2-9d4e-f5d8597e00d7	String	jsonType.label
01650d7b-3515-4e0e-9085-8be0c6d515a2	true	userinfo.token.claim
01650d7b-3515-4e0e-9085-8be0c6d515a2	gender	user.attribute
01650d7b-3515-4e0e-9085-8be0c6d515a2	true	id.token.claim
01650d7b-3515-4e0e-9085-8be0c6d515a2	true	access.token.claim
01650d7b-3515-4e0e-9085-8be0c6d515a2	gender	claim.name
01650d7b-3515-4e0e-9085-8be0c6d515a2	String	jsonType.label
419e6601-463c-4dfa-a4e8-513b96b4b9f5	true	userinfo.token.claim
419e6601-463c-4dfa-a4e8-513b96b4b9f5	birthdate	user.attribute
419e6601-463c-4dfa-a4e8-513b96b4b9f5	true	id.token.claim
419e6601-463c-4dfa-a4e8-513b96b4b9f5	true	access.token.claim
419e6601-463c-4dfa-a4e8-513b96b4b9f5	birthdate	claim.name
419e6601-463c-4dfa-a4e8-513b96b4b9f5	String	jsonType.label
f97f4535-599a-49cc-8096-606bc5604e77	true	userinfo.token.claim
f97f4535-599a-49cc-8096-606bc5604e77	zoneinfo	user.attribute
f97f4535-599a-49cc-8096-606bc5604e77	true	id.token.claim
f97f4535-599a-49cc-8096-606bc5604e77	true	access.token.claim
f97f4535-599a-49cc-8096-606bc5604e77	zoneinfo	claim.name
f97f4535-599a-49cc-8096-606bc5604e77	String	jsonType.label
20e675c9-7739-4b2e-819c-15e9de6d99bc	true	userinfo.token.claim
20e675c9-7739-4b2e-819c-15e9de6d99bc	locale	user.attribute
20e675c9-7739-4b2e-819c-15e9de6d99bc	true	id.token.claim
20e675c9-7739-4b2e-819c-15e9de6d99bc	true	access.token.claim
20e675c9-7739-4b2e-819c-15e9de6d99bc	locale	claim.name
20e675c9-7739-4b2e-819c-15e9de6d99bc	String	jsonType.label
53ef6bc8-4033-4f53-9e07-a74d9f952692	true	userinfo.token.claim
53ef6bc8-4033-4f53-9e07-a74d9f952692	updatedAt	user.attribute
53ef6bc8-4033-4f53-9e07-a74d9f952692	true	id.token.claim
53ef6bc8-4033-4f53-9e07-a74d9f952692	true	access.token.claim
53ef6bc8-4033-4f53-9e07-a74d9f952692	updated_at	claim.name
53ef6bc8-4033-4f53-9e07-a74d9f952692	String	jsonType.label
b1ce2e16-aabb-4a51-a9e7-38dbf285ad0f	true	userinfo.token.claim
b1ce2e16-aabb-4a51-a9e7-38dbf285ad0f	email	user.attribute
b1ce2e16-aabb-4a51-a9e7-38dbf285ad0f	true	id.token.claim
b1ce2e16-aabb-4a51-a9e7-38dbf285ad0f	true	access.token.claim
b1ce2e16-aabb-4a51-a9e7-38dbf285ad0f	email	claim.name
b1ce2e16-aabb-4a51-a9e7-38dbf285ad0f	String	jsonType.label
4f486ea5-3e64-45f0-9c72-51fafc0b50a3	true	userinfo.token.claim
4f486ea5-3e64-45f0-9c72-51fafc0b50a3	emailVerified	user.attribute
4f486ea5-3e64-45f0-9c72-51fafc0b50a3	true	id.token.claim
4f486ea5-3e64-45f0-9c72-51fafc0b50a3	true	access.token.claim
4f486ea5-3e64-45f0-9c72-51fafc0b50a3	email_verified	claim.name
4f486ea5-3e64-45f0-9c72-51fafc0b50a3	boolean	jsonType.label
dfe03972-302b-44f8-89e3-f8632f3730dc	formatted	user.attribute.formatted
dfe03972-302b-44f8-89e3-f8632f3730dc	country	user.attribute.country
dfe03972-302b-44f8-89e3-f8632f3730dc	postal_code	user.attribute.postal_code
dfe03972-302b-44f8-89e3-f8632f3730dc	true	userinfo.token.claim
dfe03972-302b-44f8-89e3-f8632f3730dc	street	user.attribute.street
dfe03972-302b-44f8-89e3-f8632f3730dc	true	id.token.claim
dfe03972-302b-44f8-89e3-f8632f3730dc	region	user.attribute.region
dfe03972-302b-44f8-89e3-f8632f3730dc	true	access.token.claim
dfe03972-302b-44f8-89e3-f8632f3730dc	locality	user.attribute.locality
e69b0378-67c9-4f1f-a73e-e96cb021e608	true	userinfo.token.claim
e69b0378-67c9-4f1f-a73e-e96cb021e608	phoneNumber	user.attribute
e69b0378-67c9-4f1f-a73e-e96cb021e608	true	id.token.claim
e69b0378-67c9-4f1f-a73e-e96cb021e608	true	access.token.claim
e69b0378-67c9-4f1f-a73e-e96cb021e608	phone_number	claim.name
e69b0378-67c9-4f1f-a73e-e96cb021e608	String	jsonType.label
5ee0e909-c103-4482-b76f-dc3073376af6	true	userinfo.token.claim
5ee0e909-c103-4482-b76f-dc3073376af6	phoneNumberVerified	user.attribute
5ee0e909-c103-4482-b76f-dc3073376af6	true	id.token.claim
5ee0e909-c103-4482-b76f-dc3073376af6	true	access.token.claim
5ee0e909-c103-4482-b76f-dc3073376af6	phone_number_verified	claim.name
5ee0e909-c103-4482-b76f-dc3073376af6	boolean	jsonType.label
669656b6-6e39-4af4-bd2d-c6c6305c2bd9	true	multivalued
669656b6-6e39-4af4-bd2d-c6c6305c2bd9	foo	user.attribute
669656b6-6e39-4af4-bd2d-c6c6305c2bd9	true	access.token.claim
669656b6-6e39-4af4-bd2d-c6c6305c2bd9	realm_access.roles	claim.name
669656b6-6e39-4af4-bd2d-c6c6305c2bd9	String	jsonType.label
00890afc-ce2e-4c6c-a5b2-5c49a8582c10	true	multivalued
00890afc-ce2e-4c6c-a5b2-5c49a8582c10	foo	user.attribute
00890afc-ce2e-4c6c-a5b2-5c49a8582c10	true	access.token.claim
00890afc-ce2e-4c6c-a5b2-5c49a8582c10	resource_access.${client_id}.roles	claim.name
00890afc-ce2e-4c6c-a5b2-5c49a8582c10	String	jsonType.label
4b50543f-6b21-43c4-8936-cab0e3a9db83	true	userinfo.token.claim
4b50543f-6b21-43c4-8936-cab0e3a9db83	username	user.attribute
4b50543f-6b21-43c4-8936-cab0e3a9db83	true	id.token.claim
4b50543f-6b21-43c4-8936-cab0e3a9db83	true	access.token.claim
4b50543f-6b21-43c4-8936-cab0e3a9db83	upn	claim.name
4b50543f-6b21-43c4-8936-cab0e3a9db83	String	jsonType.label
d9157ba0-88c0-4003-8483-4f55d7eb6a5f	true	multivalued
d9157ba0-88c0-4003-8483-4f55d7eb6a5f	foo	user.attribute
d9157ba0-88c0-4003-8483-4f55d7eb6a5f	true	id.token.claim
d9157ba0-88c0-4003-8483-4f55d7eb6a5f	true	access.token.claim
d9157ba0-88c0-4003-8483-4f55d7eb6a5f	groups	claim.name
d9157ba0-88c0-4003-8483-4f55d7eb6a5f	String	jsonType.label
655759a7-0ebe-4bba-aa6a-9c73fef4ddb6	true	userinfo.token.claim
655759a7-0ebe-4bba-aa6a-9c73fef4ddb6	locale	user.attribute
655759a7-0ebe-4bba-aa6a-9c73fef4ddb6	true	id.token.claim
655759a7-0ebe-4bba-aa6a-9c73fef4ddb6	true	access.token.claim
655759a7-0ebe-4bba-aa6a-9c73fef4ddb6	locale	claim.name
655759a7-0ebe-4bba-aa6a-9c73fef4ddb6	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d9564f2c-1863-4b16-84b1-3ec5a2eede05	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	aeef319a-966f-47fa-91a5-4e611ee296fc	a3622de3-5d50-47ed-8890-076742bc885f	574ebbc1-bc28-47a9-9632-56a6941c10e0	34cd2989-bfca-4690-87f3-60d3207d5c15	29e706e1-63ab-4e25-8365-42d29710d151	2592000	f	900	t	f	191eeb11-ca6e-4372-bc74-069ca0f6d426	0	f	0	0	1629bae3-a586-4f1e-85d3-a69cf6293877
redream	60	300	300	\N	\N	\N	t	f	0	\N	redream	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	62e4a9dc-894a-423c-97df-31e9138dc034	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	09707760-9053-4c27-b811-69f1fe5ea9ed	3c9c4057-00a4-4077-8ce7-37793e25addd	608558af-8ed4-4ebf-b228-b55ce3c11a04	c68b8049-9187-4f5b-96f9-744b3e641681	93b5cb98-729a-4e31-8580-e4e3acb93e1c	2592000	f	900	t	f	b6115a36-7c5e-453f-84ed-996eb84edd92	0	f	0	0	5a586dd6-c63e-4af9-89eb-9e968e82f499
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
_browser_header.contentSecurityPolicyReportOnly	redream	
_browser_header.xContentTypeOptions	redream	nosniff
_browser_header.xRobotsTag	redream	none
_browser_header.xFrameOptions	redream	SAMEORIGIN
_browser_header.contentSecurityPolicy	redream	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	redream	1; mode=block
_browser_header.strictTransportSecurity	redream	max-age=31536000; includeSubDomains
bruteForceProtected	redream	false
permanentLockout	redream	false
maxFailureWaitSeconds	redream	900
minimumQuickLoginWaitSeconds	redream	60
waitIncrementSeconds	redream	60
quickLoginCheckMilliSeconds	redream	1000
maxDeltaTimeSeconds	redream	43200
failureFactor	redream	30
defaultSignatureAlgorithm	redream	RS256
offlineSessionMaxLifespanEnabled	redream	false
offlineSessionMaxLifespan	redream	5184000
actionTokenGeneratedByAdminLifespan	redream	43200
actionTokenGeneratedByUserLifespan	redream	300
oauth2DeviceCodeLifespan	redream	600
oauth2DevicePollingInterval	redream	5
webAuthnPolicyRpEntityName	redream	keycloak
webAuthnPolicySignatureAlgorithms	redream	ES256
webAuthnPolicyRpId	redream	
webAuthnPolicyAttestationConveyancePreference	redream	not specified
webAuthnPolicyAuthenticatorAttachment	redream	not specified
webAuthnPolicyRequireResidentKey	redream	not specified
webAuthnPolicyUserVerificationRequirement	redream	not specified
webAuthnPolicyCreateTimeout	redream	0
webAuthnPolicyAvoidSameAuthenticatorRegister	redream	false
webAuthnPolicyRpEntityNamePasswordless	redream	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	redream	ES256
webAuthnPolicyRpIdPasswordless	redream	
webAuthnPolicyAttestationConveyancePreferencePasswordless	redream	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	redream	not specified
webAuthnPolicyRequireResidentKeyPasswordless	redream	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	redream	not specified
webAuthnPolicyCreateTimeoutPasswordless	redream	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	redream	false
cibaBackchannelTokenDeliveryMode	redream	poll
cibaExpiresIn	redream	120
cibaInterval	redream	5
cibaAuthRequestedUserHint	redream	login_hint
parRequestUriLifespan	redream	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
redream	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	redream
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.redirect_uris (client_id, value) FROM stdin;
0048bf46-9656-454b-a8f0-09fbea68c71d	/realms/master/account/*
f55de89e-645b-4f63-8933-5fb1620f98df	/realms/master/account/*
24fa11d7-0545-439d-8137-c281a5e2691b	/admin/master/console/*
c447134d-ed4a-45ed-86e4-8ef31e4e712b	/realms/redream/account/*
1590b1b3-f267-40ab-827d-e0d5e1d69f42	/realms/redream/account/*
e2fd7fda-86b0-4101-bd79-07dd61d9881b	/admin/redream/console/*
b39939b2-0ddb-441a-a9c2-e24fdde29f44	/
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
c4cba602-71d0-4783-8802-1c53d0a0bf40	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
4ca2c3b3-f7d5-4974-b7c9-e6fe6a048e9a	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
dc0c9474-8aa6-4e3b-83a5-2d8e8d1109f6	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
6104d49c-03c0-438c-9874-123079ee3901	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
ecb3ed75-c027-4c4f-ae8e-c4e2d0fc1316	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
2894f54b-6d38-400e-9cbd-e8a932f0e975	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
4435aa28-8b2b-4ac1-a828-216ae69e42e4	delete_account	Delete Account	master	f	f	delete_account	60
716933e1-570e-4040-ba25-4238faa27008	VERIFY_EMAIL	Verify Email	redream	t	f	VERIFY_EMAIL	50
b18a949c-1a23-405d-86d9-94b9760603da	UPDATE_PROFILE	Update Profile	redream	t	f	UPDATE_PROFILE	40
99018925-ca80-4832-98c8-e4fe75153eec	CONFIGURE_TOTP	Configure OTP	redream	t	f	CONFIGURE_TOTP	10
6e019a8f-c0e0-45bb-9a00-2b1192d4462c	UPDATE_PASSWORD	Update Password	redream	t	f	UPDATE_PASSWORD	30
0691c57f-25a6-4415-b2c2-d317aab39e24	terms_and_conditions	Terms and Conditions	redream	f	f	terms_and_conditions	20
54aee62c-39e5-42a1-8b9d-f4f9d45a8693	update_user_locale	Update User Locale	redream	t	f	update_user_locale	1000
a4132969-4ca8-4e50-a86f-c5646364111e	delete_account	Delete Account	redream	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
f55de89e-645b-4f63-8933-5fb1620f98df	d9fc411a-cc9d-422c-b8b8-04380c86c032
1590b1b3-f267-40ab-827d-e0d5e1d69f42	aa8286cc-13c6-445d-b8ca-f9f355e22640
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
2625de39-4ad0-41fa-9fe1-be10682191a8	\N	f03ea936-cdc1-4daa-9d88-d496569bf6a0	f	t	\N	\N	\N	master	admin	1635345629930	\N	0
d5c5caf0-f208-4028-b1d9-0595aa3847e6	\N	8ca01dc9-ce9c-47f3-9f5b-82c1705ffb49	f	t	\N	\N	\N	redream	toto	1635864699390	\N	1635865960
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
1629bae3-a586-4f1e-85d3-a69cf6293877	2625de39-4ad0-41fa-9fe1-be10682191a8
d13d2ee5-fb92-4e74-82a2-2fb1e7de30a3	2625de39-4ad0-41fa-9fe1-be10682191a8
5a586dd6-c63e-4af9-89eb-9e968e82f499	d5c5caf0-f208-4028-b1d9-0595aa3847e6
1ac09382-c08e-4954-9c18-f5cde8d0463a	d5c5caf0-f208-4028-b1d9-0595aa3847e6
f2e91caf-9098-4965-9aa1-36f23c2c4dcc	d5c5caf0-f208-4028-b1d9-0595aa3847e6
b53dac72-1dbe-4c92-974e-168437883604	d5c5caf0-f208-4028-b1d9-0595aa3847e6
15f2c5b8-f958-43e4-bc7f-e5a33a5738a0	d5c5caf0-f208-4028-b1d9-0595aa3847e6
fee70758-1cc7-44d7-9fec-b7855b60acd9	d5c5caf0-f208-4028-b1d9-0595aa3847e6
68b3fb89-2aee-46c0-8ad4-b3d817c40562	d5c5caf0-f208-4028-b1d9-0595aa3847e6
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.vehicle (id, description, energy, name, type, ascent, auxiliary_consumption, charging_curve, charging_setup_duration, connector_type, descent, free_flow_speed_table, max_charge, max_charging_current, max_charging_voltage, trafic_speed_table) FROM stdin;
4	Walk	0	Walk	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	Bike	0	Bike	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	Tesla Model 3 2021	1	Tesla Model 3	3	9	1.8	0,239,32,199,56,167,60,130,64,111,68,83,72,55,76,33,78,17,80,1	300	iec62196Type1Combo,iec62196Type2Combo,Chademo,Tesla	4.3	0,0.239,27,0.239,45,0.259,60,0.196,75,0.207,90,0.238,100,0.26,110,0.296,120,0.337,130,0.351,250,0.351	54	600	400	0,0.349,27,0.319,45,0.329,60,0.266,75,0.287,90,0.318,100,0.33,110,0.335,120,0.35,130,0.36,250,0.36
2	Tesla Model Y 2021	1	Tesla Model Y	3	9	1.8	0,239,32,199,56,167,60,130,64,111,68,83,72,55,76,33,78,17,80,1	300	iec62196Type1Combo,iec62196Type2Combo,Chademo,Tesla	4.3	0,0.239,27,0.239,45,0.259,60,0.196,75,0.207,90,0.238,100,0.26,110,0.296,120,0.337,130,0.351,250,0.351	60	600	400	0,0.349,27,0.319,45,0.329,60,0.266,75,0.287,90,0.318,100,0.33,110,0.335,120,0.35,130,0.36,250,0.36
3	Tesla Model X 2021	1	Tesla Model X	3	9	1.8	0,239,32,199,56,167,60,130,64,111,68,83,72,55,76,33,78,17,80,1	300	iec62196Type1Combo,iec62196Type2Combo,Chademo,Tesla	4.3	0,0.239,27,0.239,45,0.259,60,0.196,75,0.207,90,0.238,100,0.26,110,0.296,120,0.337,130,0.351,250,0.351	95	600	400	0,0.349,27,0.319,45,0.329,60,0.266,75,0.287,90,0.318,100,0.33,110,0.335,120,0.35,130,0.36,250,0.36
6	Peugeot 208	5	Peugeot 208	3	3.917297486	0	0,1,1000000,1	300	iec62196Type1Combo,iec62196Type2Combo,Chademo,Tesla	0	0,0.33962,10,0.283589,20,0.236698,30,0.198947,40,0.170336,50,0.150865,60,0.140534,70,0.139343,80,0.147292,90,0.164381,100,0.19061,110,0.225979,120,0.270488,130,0.324137	1000000	600	400	0,0.33962,10,0.283589,20,0.236698,30,0.198947,40,0.170336,50,0.150865,60,0.140534,70,0.139343,80,0.147292,90,0.164381,100,0.19061,110,0.225979,120,0.270488,130,0.324137
7	Peugeot 2008	4	Peugeot 2008	3	4.592435873	1.8	0,1,1000000,1	300	iec62196Type1Combo,iec62196Type2Combo,Chademo,Tesla	0	0,0.29401,10,0.254172,20,0.221614,30,0.196336,40,0.178338,50,0.16762,60,0.164182,70,0.168024,80,0.179146,90,0.197548,100,0.22323,110,0.256192,120,0.296434,130,0.343956	1000000	600	400	0,0.29401,10,0.254172,20,0.221614,30,0.196336,40,0.178338,50,0.16762,60,0.164182,70,0.168024,80,0.179146,90,0.197548,100,0.22323,110,0.256192,120,0.296434,130,0.343956
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.web_origins (client_id, value) FROM stdin;
24fa11d7-0545-439d-8137-c281a5e2691b	+
e2fd7fda-86b0-4101-bd79-07dd61d9881b	+
\.


--
-- Name: vehicle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.vehicle_id_seq', 6, true);


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (id);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: sa
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

